package com.wellness365.app.Action;

import android.content.Context;
import android.content.Intent;
import android.os.Handler;
import android.os.HandlerThread;
import android.util.Log;

import androidx.localbroadcastmanager.content.LocalBroadcastManager;

import com.wellness365.app.Helper.JasonHelper;

import org.json.JSONObject;

import java.util.HashMap;


public class JasonTimerAction {
    private HashMap<String, Runnable> timers;
    private Handler handler;
    public JasonTimerAction(){
        HandlerThread thread = new HandlerThread("TimerThread");
        thread.start();
        timers = new HashMap<String, Runnable>();
        handler = new Handler(thread.getLooper());
    }
    public void start(final JSONObject action, final JSONObject data, final JSONObject event, final Context context){
        try {
            if (action.has("options")) {
                JSONObject options = action.getJSONObject("options");
                if(options.has("name")){

                    String name = options.getString("name");

                    // Look up timer
                    // if it exists, reset first, and then start
                    if(timers.get(name) != null){
                        cancelTimer(name);
                    }

                    Boolean repeats = options.has("repeats");
                    final int interval = (int)(Float.valueOf(options.getString("interval"))*1000);
                    final JSONObject timerAction = options.getJSONObject("action");
                    
                    //if 'repeat' property exists, it will read the boolean value
                    //before this fix, the value 'repeat = false' would still trigger the repeat function
                    
                    if(repeats) {
                        repeats = options.getBoolean("repeats");
                    }
                    
                    //this is a new field implementation called 'skip'. It gives an alternate option to the repeating loop
                    //if false, or undefined, it will do nothing. But if set to 'true', it will trigger the interval, but will skip the first iteration
                    Boolean skipFirstInteraction = options.has("skip");
                    
                    if(skipFirstInteraction) {
                        skipFirstInteraction = options.getBoolean("skip");
                    }


                    if(repeats) {
                        final Runnable runnableCode = new Runnable() {
                            @Override
                            public void run() {
                                Log.d("Handlers", "Called on main thread");

                                Intent intent = new Intent("call");
                                intent.putExtra("action", timerAction.toString());
                                LocalBroadcastManager.getInstance(context).sendBroadcast(intent);
                                handler.postDelayed(this, interval);
                            }
                        };
                        
                        //if skip = true, it will delay the first iteration
                        if (skipFirstInteraction) {
                            handler.postDelayed(runnableCode, interval);
                        } else {
                            //skip = false or null/undefined
                            handler.post(runnableCode);
                        }

                        // Register timer
                        timers.put(name, runnableCode);
                    } else {
                        final Runnable runnableCode = new Runnable() {
                            @Override
                            public void run() {
                                Log.d("Handlers", "Called on main thread");

                                Intent intent = new Intent("call");
                                intent.putExtra("action", timerAction.toString());
                                LocalBroadcastManager.getInstance(context).sendBroadcast(intent);
                            }
                        };
                        handler.postDelayed(runnableCode, interval);

                        // Register timer
                        timers.put(name, runnableCode);
                    }

                }
            }

            // Go on to the next success action
            JasonHelper.next("success", action, data, event, context);

        } catch (Exception e){
            Log.d("Warning", e.getStackTrace()[0].getMethodName() + " : " + e.toString());
        }
    }

    public void stop(final JSONObject action, final JSONObject data, final JSONObject event, final Context context){
        try {
            if (action.has("options")) {
                JSONObject options = action.getJSONObject("options");
                if (options.has("name")) {
                    cancelTimer(options.getString("name"));
                } else {
                    cancelTimer(null);
                }
            } else {
                cancelTimer(null);
            }

            // Go on to the next success action
            JasonHelper.next("success", action, data, event, context);
        } catch (Exception e){
            Log.d("Warning", e.getStackTrace()[0].getMethodName() + " : " + e.toString());
        }

    }

    private void cancelTimer(String name){
        if(name != null) {
            Runnable runnableCode = timers.get(name);
            if(runnableCode != null) {
                handler.removeCallbacks(runnableCode);
                timers.remove(name);
            }
        } else {
            // Cancel all timers
            for (String key : timers.keySet()) {
                Runnable runnableCode = timers.get(key);
                handler.removeCallbacks(runnableCode);
                timers.remove(name);
            }
        }
    }
}
