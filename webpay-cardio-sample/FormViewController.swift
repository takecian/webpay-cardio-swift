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
    private var tap: UITapGestureRecognizer!

    override func viewDidLoad() {
        super.viewDidLoad()
        CardIOUtilities.preload()

        let cameraButton = UIBarButtonItem(image: UIImage(named: "Camera"), style: .Plain, target: self, action: "onCameraTapped:")
        navigationItem.rightBarButtonItem = cameraButton

        form = WPYCardFormView(frame: cardBaseView.bounds, card: card)
        form.delegate = self
        cardBaseView.addSubview(form)
        
        payButton.enabled = false
        priceLabel.text = "¥120"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func onCameraTapped(sender: UIBarButtonItem) {
        let cardIOVC = CardIOPaymentViewController(paymentDelegate: self)
        cardIOVC.modalPresentationStyle = .FormSheet
        presentViewController(cardIOVC, animated: true, completion: nil)
    }

    @IBAction func payButtonTapped(sender: AnyObject) {
        do {
            try card.validate()
        }catch{
            // error
            showAlert("Invalid card.")
            return
        }
        WPYTokenizer.createTokenFromCard(card, completionBlock: { [unowned self] token, error in
            if let newError = error {
                print("\(newError.localizedDescription)")
                self.showAlert("\(newError.localizedDescription)")
            } else {
                //post token to your server
                print("token = \(token.tokenId)")
                self.showAlert("token = \(token.tokenId)")
            }
        })
    }
    
    func showAlert(text: String){
        let alertController = UIAlertController(title: text, message: nil, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: {
            (action) -> Void in
        }))
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func keyboardWillShow(notification: NSNotification){
        tap = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    func keyboardWillHide(notification: NSNotification){
        view.removeGestureRecognizer(self.tap)
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }

    // MARK: WPYCardFormDelegate methods
    func validFormWithCard(creditCard: WPYCreditCard!) {
        // called when the form is valid.
        print("validFormWithCard")
        payButton.enabled = true
    }
    
    func invalidFormWithError(error: NSError!) {
        print("invalidFormWithError")
        payButton.enabled = false
    }
    
    // MARK: CardIOPaymentViewControllerDelegate
    func userDidCancelPaymentViewController(paymentViewController: CardIOPaymentViewController!) {
        paymentViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func userDidProvideCreditCardInfo(cardInfo: CardIOCreditCardInfo!, inPaymentViewController paymentViewController: CardIOPaymentViewController!) {
        if let info = cardInfo {
            card.number = info.cardNumber
            card.expiryMonth = WPYMonth(rawValue: info.expiryMonth)!
            card.expiryYear = info.expiryYear
            card.cvc = info.cvv
            
            form.removeFromSuperview()
            form = WPYCardFormView(frame: cardBaseView.bounds, card: card)
            form.delegate = self
            cardBaseView.addSubview(form)
        }
        paymentViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
