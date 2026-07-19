package com.bm.bspmer.utils;

import android.util.Log;

import org.apache.commons.codec.DecoderException;
import org.apache.commons.codec.binary.Hex;

import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

public class SecurityAES {

    private AESBean aESBean;
    private Cipher cipher;

    public SecurityAES(int MODE) {
        this.aESBean = new AESBean();
        init(MODE);
    }

    public SecurityAES(int MODE, AESBean aESBean) {
        this.aESBean = aESBean;
        init(MODE);
    }

    public void reInit(int MODE, AESBean aESBean) {
        this.aESBean = aESBean;
        init(MODE);
    }

    private void init(int MODE) {
        try {
            SecretKeySpec skeySpec = new SecretKeySpec(
                    this.aESBean.getKey().getBytes(),
                    this.aESBean.getSecretKeySpecalgorithm());
            IvParameterSpec ivspec = new IvParameterSpec(this.aESBean.getIv().getBytes());
            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
            this.cipher = cipher;
            cipher.init(MODE, skeySpec, ivspec);
        } catch (Exception ex) {
            Logger.getLogger(SecurityAES.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public String getEncryptData(String message) throws BadPaddingException, IllegalBlockSizeException {
        Log.w("SecurityAES", "Key : " + this.aESBean.getKey() + " Plaintext: " + message);
        byte[] encrypted = this.cipher.doFinal(message.getBytes());
        return asHex(encrypted);
    }

    public String getDecryptData(String encrypted) throws BadPaddingException, DecoderException, IllegalBlockSizeException {
        Log.w("SecurityAES", "Key : " + this.aESBean.getKey() + " Encrypted: " + encrypted);
        byte[] decrypted = this.cipher.doFinal(Hex.decodeHex(encrypted.toCharArray()));
        return new String(decrypted);
    }

    public static String asHex(byte[] buf) {
        StringBuilder strbuf = new StringBuilder(buf.length * 2);
        for (byte b : buf) {
            if ((b & 0xFF) < 16) {
                strbuf.append("0");
            }
            strbuf.append(Long.toString(b & 0xFF, 16));
        }
        return strbuf.toString();
    }

    public void setAESBean(AESBean aESBean) {
        this.aESBean = aESBean;
    }

    public AESBean getAESBean() {
        return this.aESBean;
    }
}
