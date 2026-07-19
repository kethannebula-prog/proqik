package com.bm.bspmer.session;

import android.content.Context;
import android.content.SharedPreferences;

public class SessionManager {

    private static final String PREF_NAME = "bsp_merchant_pref";
    private static final String KEY_IS_LOGGED_IN = "IsLoggedIn";
    private static final String KEY_USER_ID = "UserId";
    private static final String KEY_SESSION_ID = "SessionId";
    private static final String KEY_MERCHANT_ID = "MerchantId";
    private static final String KEY_TERMINAL_ID = "TerminalId";

    private final SharedPreferences prefs;

    public SessionManager(Context context) {
        prefs = context.getSharedPreferences(PREF_NAME, Context.MODE_PRIVATE);
    }

    public boolean isLoggedIn() {
        return prefs.getBoolean(KEY_IS_LOGGED_IN, false);
    }

    public void setLoggedIn(boolean loggedIn) {
        prefs.edit().putBoolean(KEY_IS_LOGGED_IN, loggedIn).apply();
    }

    public String getUserId() {
        return prefs.getString(KEY_USER_ID, null);
    }

    public void setUserId(String userId) {
        prefs.edit().putString(KEY_USER_ID, userId).apply();
    }

    public String getSessionId() {
        return prefs.getString(KEY_SESSION_ID, null);
    }

    public void setSessionId(String sessionId) {
        prefs.edit().putString(KEY_SESSION_ID, sessionId).apply();
    }

    public String getMerchantId() {
        return prefs.getString(KEY_MERCHANT_ID, null);
    }

    public void setMerchantId(String merchantId) {
        prefs.edit().putString(KEY_MERCHANT_ID, merchantId).apply();
    }

    public String getTerminalId() {
        return prefs.getString(KEY_TERMINAL_ID, null);
    }

    public void setTerminalId(String terminalId) {
        prefs.edit().putString(KEY_TERMINAL_ID, terminalId).apply();
    }

    public void clearSession() {
        prefs.edit().clear().apply();
    }
}
