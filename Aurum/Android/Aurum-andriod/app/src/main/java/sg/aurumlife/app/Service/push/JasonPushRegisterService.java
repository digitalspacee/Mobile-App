package sg.aurumlife.app.Service.push;

import android.util.Log;

import sg.aurumlife.app.Core.JasonViewActivity;
import sg.aurumlife.app.Launcher.Launcher;
import com.google.firebase.messaging.FirebaseMessagingService;

import org.json.JSONObject;

public class JasonPushRegisterService extends FirebaseMessagingService {
    @Override
    public void onNewToken(String refreshedToken) {
        super.onNewToken(refreshedToken);
        if (refreshedToken != null) {
            try {
                JSONObject payload = new JSONObject();
                payload.put("token", refreshedToken);
                JSONObject response = new JSONObject();
                response.put("$jason", payload);
                ((JasonViewActivity) Launcher.getCurrentContext()).simple_trigger("$push.onregister", response, Launcher.getCurrentContext());
            } catch (Exception e) {
                Log.d("Warning", e.getStackTrace()[0].getMethodName() + " : " + e.toString());
            }
        }
    }
}
