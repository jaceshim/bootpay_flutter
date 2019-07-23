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

import static jaceshim.bootpay_flutter.Constans.*;

/**
 * BootpayFlutterPlugin
 * @author jaceshim
 */
public class BootpayFlutterPlugin implements MethodCallHandler, PluginRegistry.ActivityResultListener {
    private final String TAG = this.getClass().getSimpleName();
    private static final String CHANNEL_NAME = "jaceshim/bootpay_flutter";
    private Activity activity;
    private Context context;
    private MethodChannel.Result methodChannelResult;

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
        this.methodChannelResult = result;
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
    public boolean onActivityResult(int requestCode, int resultCode, Intent intent) {
        Log.d(TAG, "결제처리 요청코드 " + requestCode);
        Log.d(TAG, "결제처리 결과코드 " + resultCode);

        try {
            final String rawResultData = intent.getStringExtra(PAY_RESULT_DATA_KEY);
            Log.d(TAG, "결제처리 결과 " + rawResultData);
            if (rawResultData != null) {
                Map<String, Object> resultDada = new Gson().fromJson(rawResultData, Map.class);
                finishWithSuccess(resultDada);
            } else {
                finishWithError("결제응답값 없음", "결제응답값 없음");
            }
        } catch (Exception e) {
            finishWithError("결제처리 에러", e.getMessage());
            Log.e(TAG, "bootpay 결제처리 오류 : " + e.getMessage(), e);
        }
        return true;
    }

    /**
     * Flutter MethodChannel로 성공 응답을 전달한다.
     */
    private void finishWithSuccess(Map<String, Object> resultDada) {
        System.out.println("success data : " + resultDada.toString());
        this.methodChannelResult.success(resultDada);
    }

    /**
     * Flutter MethodChannel로 에러(실패) 응답을 전달한다.
     */
    private void finishWithError(String errorCode, String errorMessage) {
        this.methodChannelResult.error(errorCode, errorMessage, null);
    }    
}
