package com.bm.bspmer.ui;

import android.Manifest;
import android.content.pm.PackageManager;
import android.content.res.AssetManager;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;

import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import com.bm.bspmer.R;
import com.bm.bspmer.custom.MyBaseActivity;
import com.bm.bspmer.utils.LayoutConfig;

import java.io.InputStream;
import java.util.Properties;

public class SplashActivity extends MyBaseActivity {

    private static final String TAG = "SplashActivity";
    private static final int PERMISSION_REQUEST_CODE = 100;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_splash);

        LayoutConfig.init(this);
        loadAppConfig();
        checkPermissionsAndProceed();
    }

    private void loadAppConfig() {
        try {
            AssetManager assetManager = getAssets();
            InputStream inputStream = assetManager.open("app_config.properties");
            Properties properties = new Properties();
            properties.load(inputStream);
            if (properties.containsKey("server_url")) {
                LayoutConfig.SERVER_URL = properties.getProperty("server_url");
            }
        } catch (Exception e) {
            Log.w(TAG, "No app_config.properties found, using default URL");
        }
    }

    private void checkPermissionsAndProceed() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            if (ContextCompat.checkSelfPermission(this, Manifest.permission.POST_NOTIFICATIONS)
                    != PackageManager.PERMISSION_GRANTED) {
                ActivityCompat.requestPermissions(
                        this,
                        new String[]{Manifest.permission.POST_NOTIFICATIONS,
                                Manifest.permission.CAMERA},
                        PERMISSION_REQUEST_CODE);
                return;
            }
        }
        navigateToNext();
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if (requestCode == PERMISSION_REQUEST_CODE) {
            navigateToNext();
        }
    }

    private void navigateToNext() {
        new Handler().postDelayed(() -> {
            // Check if already logged in
            String isLoggedIn = LayoutConfig.pullAppData("IS_LOGGED_IN");
            if ("true".equals(isLoggedIn)) {
                startActivity(SecureActivity.newIntent(this));
            } else {
                startActivity(SecureActivity.newIntent(this));
            }
            finish();
        }, 1500);
    }
}
