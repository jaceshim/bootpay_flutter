//
//  BootpayViewController.swift
//  Runner
//
//  Created by Jace Shim on 03/06/2019.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation
import UIKit
import SwiftyBootpay

class BootpayViewController: UIViewController {
    var vc: BootpayController!
    var payParam: Dictionary<String, Any> = [:]
    var payResult: Dictionary<String, Any> = [:]
    var flutterResult:FlutterResult?

    override func viewDidLoad() {
        super.viewDidLoad()
        doPay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func doPay() {
        print("payParams : ", payParam)

        var userInfo: [String: String] = [:]
        // 구매자 정보
//        let userInfoStr = params?["userInfo"] as String
        let userInfoOfParams = payParam["userInfo"] as! Dictionary<String, Any>

        if let username = userInfoOfParams["username"] as? String {
            userInfo["username"] = username
        }

        if let email = userInfoOfParams["email"] as? String {
            userInfo["email"] = email
        }

        if let addr = userInfoOfParams["addr"] as? String {
            userInfo["addr"] = addr
        } else {
            userInfo["addr"] = ""
        }

        if let cellphone = userInfoOfParams["phone"] as? String {
            userInfo["phone"] = cellphone
        } else {
            userInfo["phone"] = ""
        }

        vc = BootpayController()

        let payPrice:NSString = payParam["price"] as! NSString

        // 주문정보 - 실제 결제창에 반영되는 정보
        let payMethod = payParam["method"] as? String ?? ""
        vc.params {
            $0.price = payPrice.doubleValue // 결제할 금액
            $0.name = payParam["name"] as! String // 결제할 상품명
            $0.order_id = payParam["orderId"] as! String //고유 주문번호로, 생성하신 값을 보내주셔야 합니다.
            $0.user_info = userInfo // 구매자 정보
            $0.pg = payParam["pg"] as? String ?? ""// 결제할 PG사
            $0.phone = userInfo["phone"]!// 구매자 휴대폰 번호
            $0.method = payMethod.lowercased()// 결제수단
            $0.sendable = self // 이벤트를 처리할 protocol receiver
//            $0.quotas = [0,2,3] // // 5만원 이상일 경우 할부 허용범위 설정 가능, (예제는 일시불, 2개월 할부, 3개월 할부 허용)
        }


        self.view.addSubview(vc.view)
    }

    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}


//MARK: Bootpay Callback Protocol
extension BootpayViewController: BootpayRequestProtocol {
    // 에러가 났을때 호출되는 부분
    func onError(data: [String: Any]) {
        buildResults(data: data)
    }

    // 가상계좌 입금 계좌번호가 발급되면 호출되는 함수입니다.
    func onReady(data: [String: Any]) {
    }

    // 결제가 진행되기 바로 직전 호출되는 함수로, 주로 재고처리 등의 로직이 수행
    func onConfirm(data: [String: Any]) {
        let iWantPay = true
        if iWantPay == true {  // 재고가 있을 경우.
            vc.transactionConfirm(data: data) // 결제 승인
        } else { // 재고가 없어 중간에 결제창을 닫고 싶을 경우
            vc.removePaymentWindow()
        }
    }

    // 결제 취소시 호출
    func onCancel(data: [String: Any]) {
        buildResults(data: data)
    }

    // 결제완료시 호출
    // 아이템 지급 등 데이터 동기화 로직을 수행합니다
    func onDone(data: [String: Any]) {
        buildResults(data: data)
    }

    //결제창이 닫힐때 실행되는 부분
    func onClose() {
        vc.dismiss() //결제창 종료
        // 이전화면으로

//        // AppDelegate 객체의 인스턴스를 가져온다.
//        let ad = UIApplication.shared.delegate as? AppDelegate
//        ad?.payResult = self.payResult

        self.flutterResult?(self.payResult)

        // 이전 화면으로 복귀한다.
        self.presentingViewController?.dismiss(animated: true)
    }

    func buildResults(data: Dictionary<String, Any>) {
        self.payResult = data
    }
}
