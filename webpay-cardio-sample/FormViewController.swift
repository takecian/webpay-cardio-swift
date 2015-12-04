//
//  FormViewController.swift
//  webpay-cardio-sample
//
//  Created by Fujiki Takeshi on 12/4/15.
//  Copyright © 2015 takecian. All rights reserved.
//

import UIKit
import WebPay

class FormViewController: UIViewController, WPYCardFormViewDelegate, CardIOPaymentViewControllerDelegate {

    let card = WPYCreditCard()
    var form: WPYCardFormView!

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var cardBaseView: UIView!
    @IBOutlet weak var payButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CardIOUtilities.preload()

        // Do any additional setup after loading the view.
        form = WPYCardFormView(frame: cardBaseView.bounds, card: card)
        form.delegate = self
        cardBaseView.addSubview(form)
        
        let cameraButton = UIBarButtonItem(image: UIImage(named: "Camera"), style: .Plain, target: self, action: "onCameraTapped:")
        navigationItem.rightBarButtonItem = cameraButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onCameraTapped(sender: UIBarButtonItem) {
        let cardIOVC = CardIOPaymentViewController(paymentDelegate: self)
        cardIOVC.modalPresentationStyle = .FormSheet
        presentViewController(cardIOVC, animated: true, completion: nil)
    }

    // MARK: WPYCardFormDelegate methods
    func validFormWithCard(creditCard: WPYCreditCard!) {
        // called when the form is valid.
    }
    
    func invalidFormWithError(error: NSError!) {
        
    }
    
    // MARK: CardIOPaymentViewControllerDelegate
    func userDidCancelPaymentViewController(paymentViewController: CardIOPaymentViewController!) {
        paymentViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func userDidProvideCreditCardInfo(cardInfo: CardIOCreditCardInfo!, inPaymentViewController paymentViewController: CardIOPaymentViewController!) {
        if let info = cardInfo {
            let str = NSString(format: "Received card info.\n Number: %@\n expiry: %02lu/%lu\n cvv: %@.", info.redactedCardNumber, info.expiryMonth, info.expiryYear, info.cvv)
            card.number = info.redactedCardNumber
        }
        paymentViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
