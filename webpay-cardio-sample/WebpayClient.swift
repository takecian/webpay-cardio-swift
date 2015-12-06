//
//  WebpayClient.swift
//  webpay-cardio-sample
//
//  Created by FUJIKI TAKESHI on 2015/12/06.
//  Copyright © 2015年 takecian. All rights reserved.
//

import UIKit
import Alamofire

class WebpayClient: NSObject {
    static let publicKey = "test_public_XXXXXXXXXXXXXXXXXXXXXXXX"
    static let secretKey = "test_secret_XXXXXXXXXXXXXXXXXXXXXXXX"

    class func charge(amount: Int, token: String, handler: ((Bool) -> Void)) {
        let param: [String : AnyObject] = ["amount": amount,
            "currency" : "jpy",
            "card" : token]
        Alamofire.request(.GET, "https://api.webpay.jp/v1/charges", parameters: param, encoding: .URL, headers: ["Authorization": "Bearer \(WebpayClient.secretKey)"])
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                handler(response.result.isSuccess)
        }
    }
}
