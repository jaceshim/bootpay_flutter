package jaceshim.bootpay_flutter;

import android.content.Intent;
import android.util.Log;
import com.google.gson.Gson;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

import java.util.Map;

import static jaceshim.bootpay_flutter.Constans.*;
import static jaceshim.bootpay_flutter.Constans.PAY_ACTIVITY_REQ_CODE;
import static jaceshim.bootpay_flutter.Constans.PAY_RESULT_CODE_KEY;
import static jaceshim.bootpay_flutter.Constans.PAY_RESULT_DATA_KEY;

/**
 * bootpay delegate concreate class
 * @author jaceshim
 */
public class BootpayDelegateImpl implements BootpayDelegate, PluginRegistry.ActivityResultListener {
    private final String TAG = this.getClass().getSimpleName();
    private final PluginRegistry.Registrar registrar;
    private MethodChannel.Result methodChannelResult;

    public BootpayDelegateImpl(PluginRegistry.Registrar registrar) {
        this.registrar = registrar;
        registrar.addActivityResultListener(this);
    }

    @Override
    public boolean onActivityResult(int requestCode, int resultCode, Intent data) {
        if (requestCode == PAY_ACTIVITY_REQ_CODE) {
            Log.d(TAG, "결제처리 요청코드 " + requestCode);
            Log.d(TAG, "결제처리 결과코드 " + resultCode);

            final String rawResultData = data.getStringExtra(PAY_RESULT_DATA_KEY);
            Log.d(TAG, "결제처리 결과 " + rawResultData);
            if (rawResultData != null) {
                Map<String, Object> resultDada = new Gson().fromJson(rawResultData, Map.class);
                final int paymentResultCode = data.getIntExtra(PAY_RESULT_CODE_KEY, PaymentResultCode.ERROR.getCode());
                resultDada.put("status", PaymentResultCode.of(paymentResultCode).name());
                finishWithSuccess(resultDada);
            } else {
                finishWithError("결제응답값 없음", "결제응답값 없음");
            }
        }

        return true;
    }

    @Override
    public void init(MethodChannel.Result result) {
        this.methodChannelResult = result;
    }

    @Override
    public void pay(Map<String, Object> params) {
        Log.d(TAG, "결제요청 파라미터 : " + params.toString());

        final Intent intent = new Intent(this.registrar.activity(), BootpayActivity.class);
        intent.putExtra(PAY_PARAM_KEY, new Gson().toJson(params));
        intent.putExtra(REQ_CODE_KEY, PaymentReqCode.PAY.getCode());
        this.registrar.activity().startActivityForResult(intent, PAY_ACTIVITY_REQ_CODE);
    }

    @Override
    public void cancel(Map<String, Object> params) {
        // Not yet.
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