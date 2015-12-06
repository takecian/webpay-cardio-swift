# webpay-cardio-swift
Sample project which uses Webpay and CardIO written in Swift.

Webpay と Card IO を使ったサンプルプロジェクトです。

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

Set your key in AppDelegate.swift.
To get key, go to https://webpay.jp/.

```
WPYTokenizer.setPublicKey("your public key")
```

3 Run app
