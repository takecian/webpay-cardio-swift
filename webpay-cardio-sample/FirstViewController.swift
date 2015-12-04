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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func buttonTapped(sender: AnyObject) {
        let paymentViewController = WPYPaymentViewController(priceTag: "¥350", callback: { viewController, token, error in
            if let newError = error {
                print("error:\(error.localizedDescription)")
            } else {
                //post token to your server
                
                // when transaction is complete
                viewController.setPayButtonComplete()
                viewController.dismissAfterDelay(2.0)
            }
        })
        
        navigationController?.pushViewController(paymentViewController, animated: true)
    }
    
    @IBAction func goButtonTapped(sender: AnyObject) {
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewControllerWithIdentifier("Form")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
