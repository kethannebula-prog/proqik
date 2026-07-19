package com.bm.bspmer.utils;

import android.content.Context;

import com.bm.bspmer.R;

public class AESBean {
    private String key;
    private String iv;
    private String algorithm;
    private String secretKeySpecalgorithm;

    public AESBean() {
        this.key = "";
        this.iv = "";
        this.algorithm = "AES/CBC/PKCS5Padding";
        this.secretKeySpecalgorithm = "AES";
    }

    public AESBean(Context context) {
        this.key = context.getString(R.string.key);
        this.iv = context.getString(R.string.iv);
        this.algorithm = context.getString(R.string.algorithm);
        this.secretKeySpecalgorithm = context.getString(R.string.secretKeySpecalgorithm);
    }

    public String getKey() { return key; }
    public void setKey(String key) { this.key = key; }

    public String getIv() { return iv; }
    public void setIv(String iv) { this.iv = iv; }

    public String getAlgorithm() { return algorithm; }
    public void setAlgorithm(String algorithm) { this.algorithm = algorithm; }

    public String getSecretKeySpecalgorithm() { return secretKeySpecalgorithm; }
    public void setSecretKeySpecalgorithm(String secretKeySpecalgorithm) { this.secretKeySpecalgorithm = secretKeySpecalgorithm; }
}
