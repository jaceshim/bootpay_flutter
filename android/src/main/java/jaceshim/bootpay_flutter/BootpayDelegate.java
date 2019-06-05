package jaceshim.bootpay_flutter;

import io.flutter.plugin.common.MethodChannel;

import java.util.Map;

/**
 * bootpay delegate interface
 * @author jaceshim
 */
public interface BootpayDelegate {
    /**
     * BootpayDelegate 초기화 처리
     * @param result Flutter MethodChannel.Result
     */
    void init(MethodChannel.Result result);

    /**
     * 결제요청 처리
     * @param payParam 결제관련 파라미터
     */
    void pay(Map<String, Object> payParam);

    /**
     * 결제취소 처리 (Fixme: 현재 bootpay는 app단 결제취소가 지원되지 않음)
     * @param cancelParam 결제취소 관련 파라미터
     */
    void cancel(Map<String, Object> cancelParam);
}
