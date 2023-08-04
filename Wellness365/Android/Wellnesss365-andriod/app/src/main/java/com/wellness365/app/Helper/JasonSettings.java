package com.wellness365.app.Helper;

import android.content.Context;

import com.wellness365.app.R;

public class JasonSettings {
    public static boolean isAsync(String className, Context context) {
        String[]asyncActions = context.getResources().getStringArray(R.array.asyncActions);
        for(String s: asyncActions){
            if(s.equalsIgnoreCase(className)) return true;
        }
        return false;
    }
}
