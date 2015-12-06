//
//  FirstViewController.swift
//  webpay-cardio-sample
//
//  Created by Fujiki Takeshi on 12/4/15.
//  Copyright © 2015 takecian. All rights reserved.
//

import UIKit
import WebPay

class FirstViewController: UIViewController {
    let card = WPYCreditCard()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func buttonTapped(sender: AnyObject) {
        card.number = "4242 4242 4242 4242"
        card.expiryMonth = WPYMonth(rawValue: 8)!
        card.expiryYear = 2017
        card.cvc = "123"

        let paymentViewController = WPYPaymentViewController(priceTag: "¥350", card: card) { [unowned self] (viewController, token, error) -> Void in
            if let newError = error {
                print("\(newError.localizedDescription)")
                self.showAlert("\(newError.localizedDescription)")
            } else {
                //post token to your server
                print("token = \(token.tokenId)")
                self.showAlert("token = \(token.tokenId)")

                // when transaction is complete
                viewController.setPayButtonComplete()
                viewController.dismissAfterDelay(2.0)
            }
        }
        
        navigationController?.pushViewController(paymentViewController, animated: true)
    }
    
    @IBAction func goButtonTapped(sender: AnyObject) {
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewControllerWithIdentifier("Form")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showAlert(text: String){
        let alertController = UIAlertController(title: text, message: nil, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: {
            (action) -> Void in
        }))
        presentViewController(alertController, animated: true, completion: nil)
    }

}
