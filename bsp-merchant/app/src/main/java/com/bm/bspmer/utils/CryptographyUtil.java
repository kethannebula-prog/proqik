package com.bm.bspmer.utils;

import android.util.Base64;

import java.security.KeyFactory;
import java.security.PublicKey;
import java.security.SecureRandom;
import java.security.spec.X509EncodedKeySpec;

import javax.crypto.Cipher;

public class CryptographyUtil {

    private static final String ALGORITHM = "RSA";
    private static final String PADDING_ALGORITHM = "RSA/ECB/OAEPWithSHA-1AndMGF1Padding";

    public static String encrypt(String publicKeyBase64, String inputData) throws Exception {
        byte[] keyBytes = Base64.decode(publicKeyBase64, Base64.URL_SAFE);
        PublicKey key = KeyFactory.getInstance(ALGORITHM).generatePublic(new X509EncodedKeySpec(keyBytes));
        Cipher cipher = Cipher.getInstance(PADDING_ALGORITHM);
        cipher.init(Cipher.ENCRYPT_MODE, key);
        byte[] encryptedBytes = cipher.doFinal(inputData.getBytes("UTF-8"));
        return Base64.encodeToString(encryptedBytes, Base64.NO_WRAP);
    }

    public static String getRandomHexString(int numchars) {
        SecureRandom r = new SecureRandom();
        StringBuilder sb = new StringBuilder();
        while (sb.length() < numchars) {
            sb.append(Integer.toHexString(r.nextInt()));
        }
        return sb.toString().substring(0, numchars);
    }
}
