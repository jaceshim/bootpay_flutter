package jaceshim.bootpay_flutter.models;

import kr.co.bootpay.model.BootExtra;
import kr.co.bootpay.model.BootUser;
import kr.co.bootpay.model.Item;

import java.util.List;

/**
 * 결제 요청 파라미터
 * @author jaceshim
 */
public class PayParam {
    /**
     * 실 결제 금액
     */
    String price;

    /**
     * SDK용 Application ID (Android, iOS 각각 관리되는 값)
     */
    String applicationId;

    /**
     * 결제창에 보여질 이름
     */
    String name;

    /**
     * PG 명
     */
    String pg;

    /**
     * 결제수단, 입력하지 않으면 결제수단 선택부터 화면이 시작합니다.
     */
    String method;

    /**
     * 부트페이 정보 동의 창 보이기 여부
     */
    boolean showAgreeWindow;

    /**
     * 결제 아이템 목록
     */
    List<Item> items;

    /**
     * 사용자(구매자) 정보
     */
    BootUser userInfo;

    /**
     * 고유 주문번호로, 생성하신 값을 보내주셔야 합니다.
     */
    String orderId;

    /**
     * pg결제후 콜백받을 변수 map
     * // fixme: gson deserialized시에 type문제 해결 후 주석제거.
     */
//    Map<String, String> params;

    /**
     * 가상계좌 입금기간 제한 ( yyyy-mm-dd 포멧으로 입력해주세요. 가상계좌만 적용됩니다. )
     */
    String accountExpireAt;

    BootExtra extra;

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getApplicationId() {
        return applicationId;
    }

    public void setApplicationId(String applicationId) {
        this.applicationId = applicationId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPg() {
        return pg;
    }

    public void setPg(String pg) {
        this.pg = pg;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public boolean isShowAgreeWindow() {
        return showAgreeWindow;
    }

    public void setShowAgreeWindow(boolean showAgreeWindow) {
        this.showAgreeWindow = showAgreeWindow;
    }

    public List<Item> getItems() {
        return items;
    }

    public void setItems(List<Item> items) {
        this.items = items;
    }

    public BootUser getUserInfo() {
        return userInfo;
    }

    public void setUserInfo(BootUser userInfo) {
        this.userInfo = userInfo;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

//    public Map<String, String> getParams() {
//        return params;
//    }
//
//    public void setParams(Map<String, String> params) {
//        this.params = params;
//    }

    public String getAccountExpireAt() {
        return accountExpireAt;
    }

    public void setAccountExpireAt(String accountExpireAt) {
        this.accountExpireAt = accountExpireAt;
    }

    public BootExtra getExtra() {
        return extra;
    }

    public void setExtra(BootExtra extra) {
        this.extra = extra;
    }
}
