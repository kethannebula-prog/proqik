package com.bm.bspmer.async;

import android.os.AsyncTask;
import android.util.Log;

import com.bm.bspmer.beans.ReqResponse;
import com.bm.bspmer.converter.JSONConverter;
import com.bm.bspmer.utils.HTTPCall;
import com.bm.bspmer.utils.LayoutConfig;
import com.bm.bspmer.utils.SecurityAES;

import java.util.HashMap;

public class ConnectToServer extends AsyncTask<String, Void, String> {

    private static final String TAG = "ConnectToServer";
    private final SecurityAES securityAES;
    private final OnResponseListener listener;

    public interface OnResponseListener {
        void onSuccess(ReqResponse response);
        void onError(String error);
    }

    public ConnectToServer(SecurityAES securityAES, OnResponseListener listener) {
        this.securityAES = securityAES;
        this.listener = listener;
    }

    @Override
    protected String doInBackground(String... params) {
        try {
            String requestData = params[0];
            String encryptedRequest = securityAES.getEncryptData(requestData);

            HashMap<String, String> payload = new HashMap<>();
            payload.put("jsoncontent", encryptedRequest);

            String response = HTTPCall.sendPOST(LayoutConfig.SERVER_URL, payload);

            ReqResponse res = JSONConverter.parseResponse(response);
            if (res != null && res.getTMG() != null) {
                String decrypted = securityAES.getDecryptData(res.getTMG());
                res.setTMG(decrypted);
            }
            return JSONConverter.toJson(res);
        } catch (Exception e) {
            Log.e(TAG, "Network error", e);
            return "ERROR:" + e.getMessage();
        }
    }

    @Override
    protected void onPostExecute(String result) {
        if (result.startsWith("ERROR:")) {
            if (listener != null) {
                listener.onError(result.substring(6));
            }
        } else {
            ReqResponse response = JSONConverter.fromJson(result, ReqResponse.class);
            if (response != null && listener != null) {
                listener.onSuccess(response);
            } else if (listener != null) {
                listener.onError("Failed to parse response");
            }
        }
    }
}
