package com.bm.bspmer.utils;

import android.content.Context;
import android.content.SharedPreferences;

import java.util.HashMap;

public class LayoutConfig {

    public static final HashMap<String, String> appData = new HashMap<>();
    public static final HashMap<String, Object> appData1 = new HashMap<>();

    public static String SERVER_URL = ""; // Set via app_config.properties at runtime

    private static SharedPreferences prefs;

    public static void init(Context context) {
        prefs = context.getSharedPreferences("bsp_merchant_config", Context.MODE_PRIVATE);
    }

    public static void pushAppData(String key, String value) {
        appData.put(key, value);
        if (prefs != null) {
            prefs.edit().putString(key, value).apply();
        }
    }

    public static String pullAppData(String key) {
        if (appData.containsKey(key)) {
            return appData.get(key);
        }
        if (prefs != null && prefs.contains(key)) {
            String val = prefs.getString(key, null);
            appData.put(key, val);
            return val;
        }
        return null;
    }

    public static void clearAll() {
        appData.clear();
        appData1.clear();
        if (prefs != null) {
            prefs.edit().clear().apply();
        }
    }
}
