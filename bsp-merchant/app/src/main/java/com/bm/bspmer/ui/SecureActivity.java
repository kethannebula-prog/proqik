package com.bm.bspmer.ui;

import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;

import com.bm.bspmer.R;
import com.bm.bspmer.beans.ReqResponse;
import com.bm.bspmer.converter.JSONConverter;
import com.bm.bspmer.custom.MyBaseActivity;
import com.bm.bspmer.utils.AESBean;
import com.bm.bspmer.utils.CryptographyUtil;
import com.bm.bspmer.utils.HTTPCall;
import com.bm.bspmer.utils.LayoutConfig;
import com.bm.bspmer.utils.SecurityAES;

import java.util.HashMap;

import javax.crypto.Cipher;

public class SecureActivity extends MyBaseActivity {

    private static final String TAG = "SecureActivity";
    public static SecurityAES securityAES_REQ;
    public static SecurityAES securityAES_RES;
    public static String sessionID = "NEW";
    public static AESBean aesSecureBean;

    private ProgressDialog progressDialog;
    private String keyHolder = "0";
    private String pk = "";
    private String sk = "";

    public static Intent newIntent(Context context) {
        return new Intent(context, SecureActivity.class);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_secure);

        LayoutConfig.init(getApplicationContext());

        aesSecureBean = new AESBean(this);
        securityAES_REQ = new SecurityAES(Cipher.ENCRYPT_MODE, aesSecureBean);
        securityAES_RES = new SecurityAES(Cipher.DECRYPT_MODE, aesSecureBean);

        progressDialog = new ProgressDialog(this);
        progressDialog.setMessage("Securing connection...");
        progressDialog.setCancelable(false);

        new KeyHandshakeTask().execute();
    }

    private class KeyHandshakeTask extends AsyncTask<Void, Void, String> {

        @Override
        protected void onPreExecute() {
            progressDialog.show();
        }

        @Override
        protected String doInBackground(Void... voids) {
            try {
                HashMap<String, String> params = new HashMap<>();
                String cachedKH = LayoutConfig.pullAppData("keyHolder");
                params.put("kh", cachedKH != null && !cachedKH.isEmpty() ? cachedKH : "0");
                return HTTPCall.sendPOST(LayoutConfig.SERVER_URL, params);
            } catch (Exception e) {
                Log.e(TAG, "Handshake failed", e);
                return null;
            }
        }

        @Override
        protected void onPostExecute(String result) {
            if (result == null || result.equals("1")) {
                if (result != null && result.equals("1")) {
                    pk = LayoutConfig.pullAppData("pk");
                    keyHolder = LayoutConfig.pullAppData("keyHolder");
                }
                if (pk == null || pk.isEmpty()) {
                    progressDialog.dismiss();
                    showError("Failed to obtain security key");
                    return;
                }
                proceedWithKeyExchange();
            } else {
                try {
                    keyHolder = result.substring(0, 20);
                    pk = result.substring(20);
                    Log.w(TAG, "Handshake success - keyHolder: " + keyHolder + " pk (len=" + pk.length() + "): " + pk.substring(0, Math.min(pk.length(), 60)) + "...");
                    LayoutConfig.pushAppData("keyHolder", keyHolder);
                    LayoutConfig.pushAppData("pk", pk);
                    proceedWithKeyExchange();
                } catch (Exception e) {
                    progressDialog.dismiss();
                    showError("Invalid server response");
                }
            }
        }
    }

    private void proceedWithKeyExchange() {
        new SecureRequestTask().execute();
    }

    private class SecureRequestTask extends AsyncTask<Void, Void, String> {

        @Override
        protected String doInBackground(Void... voids) {
            try {
                String nmKey = CryptographyUtil.getRandomHexString(16);
                sk = CryptographyUtil.encrypt(pk, nmKey);

                AESBean sessionBean = new AESBean();
                sessionBean.setKey(nmKey);
                sessionBean.setIv(getString(R.string.iv));
                sessionBean.setAlgorithm(getString(R.string.algorithm));
                sessionBean.setSecretKeySpecalgorithm(getString(R.string.secretKeySpecalgorithm));

                securityAES_REQ.reInit(Cipher.ENCRYPT_MODE, sessionBean);
                securityAES_RES.reInit(Cipher.DECRYPT_MODE, sessionBean);

                ReqResponse req = new ReqResponse();
                req.setVCD("1.23");
                req.setTCD("12001");
                req.setTMG(LayoutConfig.pullAppData("APP_ID") != null ? LayoutConfig.pullAppData("APP_ID") : "50500");
                req.setRCD("1.0.0");
                req.setRMG("SUCCESS");
                req.setSID(sessionID);

                String requestData = JSONConverter.toJson(req);
                String encryptedData = securityAES_REQ.getEncryptData(requestData);

                Log.w(TAG, "sk (raw): " + sk);
                Log.w(TAG, "encryptedData (raw): " + encryptedData);

                HashMap<String, String> params = new HashMap<>();
                params.put("jsoncontent", encryptedData);
                params.put("sk", sk);
                params.put("kh", keyHolder);

                return HTTPCall.sendPOST(LayoutConfig.SERVER_URL, params);
            } catch (Exception e) {
                Log.e(TAG, "Secure request failed", e);
                return null;
            }
        }

        @Override
        protected void onPostExecute(String result) {
            progressDialog.dismiss();
            Log.w(TAG, "Server raw response: [" + (result != null ? result.substring(0, Math.min(result.length(), 200)) : "null") + "]");
            if (result == null) {
                showError("Secure connection failed");
                return;
            }
            try {
                String trimmed = result.trim();
                if (trimmed.startsWith("{")) {
                    ReqResponse errorRes = JSONConverter.fromJson(trimmed, ReqResponse.class);
                    String msg = errorRes != null ? errorRes.getRMG() : "Unknown error";
                    showError("Server error: " + msg);
                    return;
                }
                String decrypted = securityAES_RES.getDecryptData(trimmed);
                Log.w(TAG, "Decrypted response: " + decrypted);

                ReqResponse res = JSONConverter.fromJson(decrypted, ReqResponse.class);
                if (res != null && ("12001".equals(res.getTCD()) || "600102".equals(res.getTCD()))) {
                    sessionID = res.getSID();
                    if (res.getTMG() != null && res.getTMG().length() > 0) {
                        AESBean serverBean = JSONConverter.fromJson(res.getTMG(), AESBean.class);
                        if (serverBean != null && serverBean.getKey() != null && !serverBean.getKey().isEmpty()) {
                            securityAES_REQ.reInit(Cipher.ENCRYPT_MODE, serverBean);
                            securityAES_RES.reInit(Cipher.DECRYPT_MODE, serverBean);
                        }
                    }
                    startActivity(new Intent(SecureActivity.this, LoginActivity.class));
                    finish();
                } else {
                    showError("Unexpected server response");
                }
            } catch (Exception e) {
                Log.e(TAG, "Response parsing failed", e);
                showError("Failed to parse server response");
            }
        }
    }

    private void showError(String message) {
        Log.e(TAG, "Error: " + message);
        runOnUiThread(() -> new AlertDialog.Builder(SecureActivity.this)
                .setTitle("Connection Failed")
                .setMessage(message)
                .setPositiveButton("Retry", (dialog, which) -> new KeyHandshakeTask().execute())
                .setNegativeButton("Exit", (dialog, which) -> finish())
                .setCancelable(false)
                .show());
    }
}
