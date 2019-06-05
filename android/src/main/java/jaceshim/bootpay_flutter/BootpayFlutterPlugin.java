package jaceshim.bootpay_flutter;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import java.util.Map;

/**
 * BootpayFlutterPlugin
 * @author jaceshim
 */
public class BootpayFlutterPlugin implements MethodCallHandler {
    private final String TAG = this.getClass().getSimpleName();
    private static final String CHANNEL_NAME = "jaceshim/bootpay_flutter";

    private final BootpayDelegate bootpayDelegate;

    private BootpayFlutterPlugin(Registrar registrar) {
        bootpayDelegate = new BootpayDelegateImpl(registrar);
    }

    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), CHANNEL_NAME);
        final BootpayFlutterPlugin instance = new BootpayFlutterPlugin(registrar);
        channel.setMethodCallHandler(instance);
    }

    @Override
    public void onMethodCall(MethodCall methodCall, Result result) {
        Map<String, Object> params = methodCall.arguments();
        bootpayDelegate.init(result);
        switch (methodCall.method) {
            case "doPay":
                bootpayDelegate.pay(params);
                break;
            case "doCancel":
                bootpayDelegate.cancel(params);
                break;
            default:
                result.notImplemented();
        }
    }
}
