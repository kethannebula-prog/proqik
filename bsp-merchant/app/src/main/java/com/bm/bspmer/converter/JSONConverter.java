package com.bm.bspmer.converter;

import com.bm.bspmer.beans.ReqResponse;
import com.google.gson.Gson;
import com.google.gson.JsonSyntaxException;

public class JSONConverter {

    private static final Gson gson = new Gson();

    public static String toJson(Object obj) {
        return gson.toJson(obj);
    }

    public static <T> T fromJson(String json, Class<T> clazz) {
        try {
            return gson.fromJson(json, clazz);
        } catch (JsonSyntaxException e) {
            return null;
        }
    }

    public static ReqResponse parseResponse(String json) {
        return fromJson(json, ReqResponse.class);
    }
}
