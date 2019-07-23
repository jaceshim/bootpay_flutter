package jaceshim.bootpay_flutter;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.util.Log;
import com.google.gson.Gson;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import java.util.Map;

import static jaceshim.bootpay_flutter.Constans.PAY_ACTIVITY_REQ_CODE;
import static jaceshim.bootpay_flutter.Constans.PAY_PARAM_KEY;
import static jaceshim.bootpay_flutter.Constans.REQ_CODE_KEY;

/**
 * BootpayFlutterPlugin
 * @author jaceshim
 */
public class BootpayFlutterPlugin implements MethodCallHandler, PluginRegistry.ActivityResultListener {
    private final String TAG = this.getClass().getSimpleName();
    private static final String CHANNEL_NAME = "jaceshim/bootpay_flutter";
    private Activity activity;
    private Context context;

    private BootpayFlutterPlugin(Activity activity, Context activeContext) {
        this.activity = activity;
        this.context = context;
    }

    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), CHANNEL_NAME);
        final BootpayFlutterPlugin instance = new BootpayFlutterPlugin(registrar.activity(), registrar.activeContext());
        registrar.addActivityResultListener(instance);
        channel.setMethodCallHandler(instance);
    }

    @Override
    public void onMethodCall(MethodCall methodCall, Result result) {
        Map<String, Object> params = methodCall.arguments();
        switch (methodCall.method) {
            case "doPay":
                pay(params);
                break;
            default:
                result.notImplemented();
        }
    }

    public void pay(Map<String, Object> params) {
        Log.d(TAG, "결제요청 파라미터 : " + params.toString());

        final Intent intent = new Intent(this.activity, BootpayActivity.class);
        intent.putExtra(PAY_PARAM_KEY, new Gson().toJson(params));
        intent.putExtra(REQ_CODE_KEY, Constans.PaymentReqCode.PAY.getCode());
        this.activity.startActivityForResult(intent, PAY_ACTIVITY_REQ_CODE);
    }

    @Override
    public boolean onActivityResult(int i, int i1, Intent intent) {
        return false;
    }
}
