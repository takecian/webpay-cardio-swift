# webpay-cardio-swift
Sample project which uses Webpay and CardIO written in Swift.

Webpay(https://github.com/webpay/webpay-token-ios) と Card IO(https://github.com/card-io/card.io-iOS-SDK) を使ったサンプルプロジェクトです。

# This project does
* Get token from webpay (with WPYPaymentViewController).
* Read card information with Card.io (with WPYCardFormView).
* Charge with token.

# This project does not do
* Create customer.

# Setup

1 Install Webpay and CardIO library

```
pod install
```
2 Set public key

Set your key in WebpayClient.swift.
To get key, go to https://webpay.jp/.

```
class WebpayClient: NSObject {
    static let publicKey = "test_public_Your_Key"
    static let secretKey = "test_secret_Your_Key"
}
```

3 Run app
