package com.bm.bspmer.custom;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.view.MotionEvent;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import com.bm.bspmer.R;
import com.bm.bspmer.application.AppHandle;
import com.bm.bspmer.ui.LoginActivity;

public class MyBaseActivity extends AppCompatActivity {

    private static final long INACTIVITY_TIMEOUT_MS = 5 * 60 * 1000;
    private Handler inactivityHandler;
    private Runnable inactivityRunnable;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        inactivityHandler = new Handler();
        AppHandle.getInstance().resetSessionTimer();
    }

    @Override
    protected void onResume() {
        super.onResume();
        resetInactivityTimer();
    }

    @Override
    protected void onPause() {
        super.onPause();
        stopInactivityTimer();
    }

    @Override
    public boolean dispatchTouchEvent(MotionEvent ev) {
        if (ev.getAction() == MotionEvent.ACTION_DOWN) {
            resetInactivityTimer();
        }
        return super.dispatchTouchEvent(ev);
    }

    private void resetInactivityTimer() {
        stopInactivityTimer();
        inactivityRunnable = () -> {
            runOnUiThread(() -> {
                new AlertDialog.Builder(this)
                        .setTitle("Session Timeout")
                        .setMessage(getString(R.string.session_timeout))
                        .setCancelable(false)
                        .setPositiveButton("OK", (dialog, which) -> {
                            Intent intent = new Intent(this, LoginActivity.class);
                            intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK);
                            startActivity(intent);
                            finishAffinity();
                        })
                        .show();
            });
        };
        inactivityHandler.postDelayed(inactivityRunnable, INACTIVITY_TIMEOUT_MS);
    }

    private void stopInactivityTimer() {
        if (inactivityRunnable != null) {
            inactivityHandler.removeCallbacks(inactivityRunnable);
        }
    }
}
