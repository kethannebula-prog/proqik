package com.bm.bspmer.application;

import android.app.Activity;
import android.app.Application;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;

import com.bm.bspmer.ui.LoginActivity;

public class AppHandle extends Application {

    private static final String TAG = "AppHandle";
    private static final long SESSION_TIMEOUT_MS = 20 * 60 * 1000;

    private static AppHandle instance;
    private static Activity currentActivity;
    private Handler sessionHandler;
    private Runnable sessionRunnable;

    public static AppHandle getInstance() {
        return instance;
    }

    public static Activity getCurrentActivity() {
        return currentActivity;
    }

    @Override
    public void onCreate() {
        super.onCreate();
        instance = this;
        sessionHandler = new Handler();

        registerActivityLifecycleCallbacks(new ActivityLifecycleCallbacks() {
            @Override
            public void onActivityCreated(Activity activity, Bundle savedInstanceState) {
                activity.setRequestedOrientation(1);
            }

            @Override
            public void onActivityStarted(Activity activity) {
                currentActivity = activity;
            }

            @Override
            public void onActivityResumed(Activity activity) {
                currentActivity = activity;
                resetSessionTimer();
            }

            @Override
            public void onActivityPaused(Activity activity) {
                if (currentActivity == activity) {
                    currentActivity = null;
                }
            }

            @Override
            public void onActivityStopped(Activity activity) {}

            @Override
            public void onActivitySaveInstanceState(Activity activity, Bundle outState) {}

            @Override
            public void onActivityDestroyed(Activity activity) {}
        });
    }

    public void startUserSession() {
        resetSessionTimer();
    }

    public void resetSessionTimer() {
        if (sessionRunnable != null) {
            sessionHandler.removeCallbacks(sessionRunnable);
        }
        sessionRunnable = () -> {
            Log.w(TAG, "Session expired due to inactivity");
            onSessionLogout();
        };
        sessionHandler.postDelayed(sessionRunnable, SESSION_TIMEOUT_MS);
    }

    public void onSessionLogout() {
        Activity activity = currentActivity;
        if (activity != null) {
            Intent intent = new Intent(activity, LoginActivity.class);
            intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK);
            activity.startActivity(intent);
            activity.finishAffinity();
        }
    }
}
