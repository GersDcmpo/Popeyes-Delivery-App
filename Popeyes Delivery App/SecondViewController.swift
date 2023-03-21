//
//  SecondViewController.swift
//  Popeyes Delivery App
//
//  Created by Gerson de Ocampo on 6/13/21.
//

import UIKit

protocol DisplayViewControllerDelegate : NSObjectProtocol {
    func dataPassConfirmation(output : String)
}
    
class SecondViewController: UIViewController {

    //App Protocol
    weak var displayDelegate : DisplayViewControllerDelegate?
    
    //Swift File
    let paymentButton: RadioButtonController = RadioButtonController()
    
    //Labels
    @IBOutlet weak var TotalPrice: UILabel!
    @IBOutlet weak var cBurgerFPrice: UILabel!
    @IBOutlet weak var fBurgerFPrice: UILabel!
    @IBOutlet weak var floatFPrice: UILabel!
    @IBOutlet weak var sundaeFPrice: UILabel!
    @IBOutlet weak var spagFPrice: UILabel!
    @IBOutlet weak var tendersFPrice: UILabel!
    @IBOutlet weak var cBurgerQty: UILabel!
    @IBOutlet weak var fBurgerQty: UILabel!
    @IBOutlet weak var floatQty: UILabel!
    @IBOutlet weak var sundaeQty: UILabel!
    @IBOutlet weak var spagQty: UILabel!
    @IBOutlet weak var tendersQty: UILabel!
    @IBOutlet weak var cashLabel: UILabel!
    @IBOutlet weak var cashChangeText: UILabel!
    @IBOutlet weak var cashChange: UILabel!
    @IBOutlet weak var voucherText: UILabel!
    @IBOutlet weak var voucherPrice: UILabel!
    @IBOutlet weak var totalcomputation: UILabel!
    
    //Text Fields
    @IBOutlet weak var cashMoney: UITextField!
    @IBOutlet weak var voucherCode: UITextField!
    
    //Switches
    @IBOutlet weak var voucherSwitch: UISwitch!
    
    @IBAction func voucherSwitchAction(_ sender: Any) {
        if voucherSwitch.isOn == true {
            voucherText.isHidden = false
            voucherPrice.isHidden = false
            checkVoucher.isHidden = false
            voucherCode.isUserInteractionEnabled = true
            voucherCode.isHidden = false
            VoucherView.viewAnimateOn()
        }
        else if voucherSwitch.isOn == false {
            voucherText.isHidden = true
            voucherPrice.isHidden = true
            checkVoucher.isHidden = true
            voucherCode.isUserInteractionEnabled = false
            voucherCode.isHidden = true
            VoucherView.viewAnimateOff()
        }
    }
    
    //Radio Buttons
    @IBOutlet weak var btnPaypal: UIButton!
    @IBOutlet weak var btnGcash: UIButton!
    @IBOutlet weak var btnPaymaya: UIButton!
    @IBOutlet weak var btnCOD: UIButton!
    
    @IBAction func btnPaypalAction(_ sender: UIButton) {
        sender.btnAnimate()
        CashView.isHidden = true
        CashView.viewAnimateOff()
        paymentButton.buttonArrayUpdated(buttonSelected: sender)
    }
    @IBAction func btnGcashAction(_ sender: UIButton) {
        sender.btnAnimate()
        CashView.isHidden = true
        CashView.viewAnimateOff()
        paymentButton.buttonArrayUpdated(buttonSelected: sender)
    }
    @IBAction func btnPaymayaAction(_ sender: UIButton) {
        sender.btnAnimate()
        CashView.isHidden = true
        CashView.viewAnimateOff()
        paymentButton.buttonArrayUpdated(buttonSelected: sender)
    }
    @IBAction func btnCODAction(_ sender: UIButton) {
        sender.btnAnimate()
        CashView.isHidden = false
        CashView.viewAnimateOn()
        paymentButton.buttonArrayUpdated(buttonSelected: sender)
    }
    
    //Buttons
    @IBOutlet weak var OrderButton: UIButton!
    @IBAction func orderButton(_ sender: Any) {
        if btnCOD.isSelected {
            if cashMoney.text?.isEmpty == true {
                OrderFailed(src: OrderButton)
            }
            else if cashMoney.text?.isEmpty == false {
                OrderSuccess(src: OrderButton)
            }
        }
        else {
            digitalOrder(src: OrderButton)
        }
    }
    @IBOutlet weak var checkCash: UIButton!
    @IBAction func checkCashButton(_ sender: Any) {
        ChangeResult()
    }
    @IBOutlet weak var checkVoucher: UIButton!
    @IBAction func checkVoucherButton(_ sender: Any) {
        if voucherCode.text == String("BCS11") {
            voucherPrice.text = String("75")
        }
        else {
            voucherPrice.text = String("0")
        }
    }
    
    
    //UIView
    @IBOutlet weak var VoucherView: UIView!
    @IBOutlet weak var CashView: UIView!
    
    //Overrides and Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataPassConfirmationMessage()
        
        paymentButton.buttonArray = [btnPaypal,btnGcash,btnPaymaya,btnCOD]
        //paymentButton.defaultButton = btnCOD
        
        voucherText.isHidden = true
        voucherPrice.isHidden = true
        checkVoucher.isHidden = true
        voucherCode.isUserInteractionEnabled = false
        voucherCode.isHidden = true
        
        CashView.isHidden = true
        
        OrderButton.tag = alertTag
        
        OrderButton.addTarget(self, action: #selector(OrderFailed), for: UIControl.Event.touchDown)
    }

    func dataPassConfirmationMessage() {
        DispatchQueue.main.async {
            if let delegate = self.displayDelegate{
                if(self.TotalPrice.text!.count > 0) {
                    delegate.dataPassConfirmation(output: "Test Good")
                }
                else {
                    delegate.dataPassConfirmation(output: "Test Bad")
                }
            }
        }
    }
    
    func ChangeResult() {
        
        let initialChange = Int(totalcomputation.text!)! - Int(voucherPrice.text!)!
        let changeFinal = Int(cashMoney.text!)! - initialChange
        
        cashChange.text = String("Php \(changeFinal)")
    }
    
    //PROMPT ALERT
    
    let alertTag = 1
    
    @objc func OrderSuccess(src:UIButton) -> Void {
        let orderSuccess: UIAlertController = UIAlertController(title: "Popeyes", message: "Order confirmed. Thank you for ordering at Popeyes!", preferredStyle: UIAlertController.Style.alert)
        let alertAction: UIAlertAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        orderSuccess.addAction(alertAction)
    }
    
    @objc func OrderFailed(src:UIButton) -> Void {
        let orderFailed: UIAlertController = UIAlertController(title: "Popeyes", message: "Payment Failed. Please input an amount higher than the total.", preferredStyle: UIAlertController.Style.alert)
        let alertAction: UIAlertAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        orderFailed.addAction(alertAction)
    }
    
    @objc func digitalOrder(src:UIButton) -> Void {
        let digitalOrder: UIAlertController = UIAlertController(title: "Popeyes", message: "Order confirmed. Money will be deducted on your account. Thank you for ordering at Popeyes!", preferredStyle: UIAlertController.Style.alert)
        let alertAction: UIAlertAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        digitalOrder.addAction(alertAction)
    }
    
}


//Extensions
extension UIButton {
    func btnAnimate() {
        let bubble = CABasicAnimation(keyPath: "transform.scale")
        bubble.duration = 0.2
        bubble.beginTime = CACurrentMediaTime() + 0.1
        bubble.fromValue = 1.25
        bubble.toValue = 0.8
        bubble.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        layer.add(bubble, forKey: nil)
    }
}

extension UIView {
    func viewAnimateOn() {
        let animateVouch = CABasicAnimation(keyPath: "opacity")
        animateVouch.duration = 0.3
        animateVouch.fromValue = 0.0
        animateVouch.toValue = 1.0
        animateVouch.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        layer.add(animateVouch, forKey: nil)
    }
    func viewAnimateOff() {
        let animateVouch = CABasicAnimation(keyPath: "opacity")
        animateVouch.duration = 0.3
        animateVouch.fromValue = 1.0
        animateVouch.toValue = 0.0
        animateVouch.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        layer.add(animateVouch, forKey: nil)
    }
}
