package com.bm.bspmer.session;

import android.content.Context;
import android.content.SharedPreferences;

import androidx.security.crypto.EncryptedSharedPreferences;
import androidx.security.crypto.MasterKey;

import java.io.IOException;
import java.security.GeneralSecurityException;

public class SecurePrefsManager {

    private static final String PREF_NAME = "secure_prefs";
    private SharedPreferences prefs;

    public SecurePrefsManager(Context context) {
        try {
            MasterKey masterKey = new MasterKey.Builder(context)
                    .setKeyScheme(MasterKey.KeyScheme.AES256_GCM)
                    .build();
            prefs = EncryptedSharedPreferences.create(
                    context,
                    PREF_NAME,
                    masterKey,
                    EncryptedSharedPreferences.PrefKeyEncryptionScheme.AES256_SIV,
                    EncryptedSharedPreferences.PrefValueEncryptionScheme.AES256_GCM
            );
        } catch (GeneralSecurityException | IOException e) {
            prefs = context.getSharedPreferences(PREF_NAME + "_fallback", Context.MODE_PRIVATE);
        }
    }

    public void put(String key, String value) {
        prefs.edit().putString(key, value).apply();
    }

    public String get(String key, String defaultValue) {
        return prefs.getString(key, defaultValue);
    }

    public void remove(String key) {
        prefs.edit().remove(key).apply();
    }

    public void clearAll() {
        prefs.edit().clear().apply();
    }
}
