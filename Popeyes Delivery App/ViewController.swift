//
//  ViewController.swift
//  Popeyes Delivery App
//
//  Created by Gerson de Ocampo on 5/31/21.
//

import UIKit

class ViewController: UIViewController, DisplayViewControllerDelegate {
    func dataPassConfirmation(output: String) {
        print(output)
    }
    
    //Buttons
    @IBOutlet weak var CheckoutButton: UIButton!
    @IBOutlet weak var ResetButton: UIButton!
    
    //Text Fields
    @IBOutlet weak var cBurgerResult: UITextField!
    @IBOutlet weak var fBurgerResult: UITextField!
    @IBOutlet weak var floatResult: UITextField!
    @IBOutlet weak var sundaeResult: UITextField!
    @IBOutlet weak var spagResult: UITextField!
    @IBOutlet weak var tendersResult: UITextField!
        
    //Labels
    @IBOutlet weak var orderTotal: UILabel?
    @IBOutlet weak var cBurgerFRTotal: UILabel?
    @IBOutlet weak var fBurgerFRTotal: UILabel?
    @IBOutlet weak var floatFRTotal: UILabel?
    @IBOutlet weak var sundaeFRTotal: UILabel?
    @IBOutlet weak var spagFRTotal: UILabel?
    @IBOutlet weak var tendersFRTotal: UILabel?
    @IBOutlet weak var totalComputation: UILabel!
    
    //Steppers
    @IBOutlet weak var cBurgerStepper: UIStepper!
    @IBOutlet weak var fBurgerStepper: UIStepper!
    @IBOutlet weak var floatStepper: UIStepper!
    @IBOutlet weak var sundaeStepper: UIStepper!
    @IBOutlet weak var spagStepper: UIStepper!
    @IBOutlet weak var tendersStepper: UIStepper!
        
    //Stepper Value to Text Field
    @IBAction func cBurgerStepperChanged(_ sender: UIStepper) {
        cBurgerResult.text = Int(sender.value).description
        checkTotal(sender.value)
    }
        
    @IBAction func fBurgerStepperChanged(_ sender: UIStepper) {
        fBurgerResult.text = Int(sender.value).description
        checkTotal(sender.value)
    }
        
    @IBAction func floatStepperChanged(_ sender: UIStepper) {
        floatResult.text = Int(sender.value).description
        checkTotal(sender.value)
    }
        
    @IBAction func sundaeStepperChanged(_ sender: UIStepper) {
        sundaeResult.text = Int(sender.value).description
        checkTotal(sender.value)
    }
        
    @IBAction func spagStepperChanged(_ sender: UIStepper) {
        spagResult.text = Int(sender.value).description
        checkTotal(sender.value)
    }
        
    @IBAction func tendersStepperChanged(_ sender: UIStepper) {
        tendersResult.text = Int(sender.value).description
        checkTotal(sender.value)
    }
    
    //Prices
    let spagPrice: Int = 55
    let tendersPrice : Int = 90
    let cBurgerPrice : Int = 45
    let fBurgerPrice : Int = 120
    let sundaePrice: Int = 30
    let floatPrice : Int = 20
    
    //Overrides and Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cBurgerStepper.layer.cornerRadius = 7.5
        fBurgerStepper.layer.cornerRadius = 7.5
        floatStepper.layer.cornerRadius = 7.5
        sundaeStepper.layer.cornerRadius = 7.5
        spagStepper.layer.cornerRadius = 7.5
        tendersStepper.layer.cornerRadius = 7.5
        
        cBurgerStepper.tintColor = UIColor.white
        fBurgerStepper.tintColor = UIColor.white
        floatStepper.tintColor = UIColor.white
        sundaeStepper.tintColor = UIColor.white
        spagStepper.tintColor = UIColor.white
        tendersStepper.tintColor = UIColor.white
            
        CheckoutButton.layer.cornerRadius = 7.5
        CheckoutButton.tintColor = UIColor.white
        
        ResetButton.layer.cornerRadius = 7.5
        ResetButton.tintColor = UIColor.white
        
        cBurgerStepper.wraps = true
        fBurgerStepper.wraps = true
        floatStepper.wraps = true
        sundaeStepper.wraps = true
        spagStepper.wraps = true
        tendersStepper.wraps = true
            
        cBurgerStepper.autorepeat = true
        fBurgerStepper.autorepeat = true
        floatStepper.autorepeat = true
        sundaeStepper.autorepeat = true
        spagStepper.autorepeat = true
        tendersStepper.autorepeat = true
            
        cBurgerStepper.minimumValue = 0
        fBurgerStepper.minimumValue = 0
        floatStepper.minimumValue = 0
        sundaeStepper.minimumValue = 0
        spagStepper.minimumValue = 0
        tendersStepper.minimumValue = 0
        
        cBurgerStepper.maximumValue = 30
        fBurgerStepper.maximumValue = 30
        floatStepper.maximumValue = 30
        sundaeStepper.maximumValue = 30
        spagStepper.maximumValue = 30
        tendersStepper.maximumValue = 30
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goSVC") {
            let svc = segue.destination as! SecondViewController
            svc.displayDelegate = self
            DispatchQueue.main.async {
                //Total
                svc.TotalPrice?.text = self.orderTotal?.text
                //Initial Total
                svc.cBurgerFPrice?.text = self.cBurgerFRTotal?.text
                svc.fBurgerFPrice?.text = self.fBurgerFRTotal?.text
                svc.floatFPrice?.text = self.floatFRTotal?.text
                svc.sundaeFPrice?.text = self.sundaeFRTotal?.text
                svc.spagFPrice?.text = self.spagFRTotal?.text
                svc.tendersFPrice?.text = self.tendersFRTotal?.text
                //Quantity
                svc.cBurgerQty?.text = self.cBurgerResult?.text
                svc.fBurgerQty?.text = self.fBurgerResult?.text
                svc.floatQty?.text = self.floatResult?.text
                svc.sundaeQty?.text = self.sundaeResult?.text
                svc.spagQty?.text = self.spagResult?.text
                svc.tendersQty?.text = self.tendersResult?.text
                //Computation
                svc.totalcomputation?.text = self.totalComputation?.text
            }
        }
    }
    
    func checkTotal(_ sender: Any) {
        
        //Computation
        let cBurgerTotal = Int(cBurgerResult.text!)! * cBurgerPrice
        let fBurgerTotal = Int(fBurgerResult.text!)! * fBurgerPrice
        let floatTotal = Int(floatResult.text!)! * floatPrice
        let sundaeTotal = Int(sundaeResult.text!)! * sundaePrice
        let spagTotal = Int(spagResult.text!)! * spagPrice
        let tendersTotal = Int(tendersResult.text!)! * tendersPrice
        
        //Total
        
        let totalPrice = Int(cBurgerTotal + fBurgerTotal + floatTotal +
                                sundaeTotal + spagTotal + tendersTotal)
        
        cBurgerFRTotal?.text = String?("Php \(cBurgerTotal)")
        fBurgerFRTotal?.text = String?("Php \(fBurgerTotal)")
        floatFRTotal?.text = String?("Php \(floatTotal)")
        sundaeFRTotal?.text = String?("Php \(sundaeTotal)")
        spagFRTotal?.text = String?("Php \(spagTotal)")
        tendersFRTotal?.text = String?("Php \(tendersTotal)")
        
        orderTotal?.text = String?("Php \(totalPrice)")
        
        totalComputation.text = String?("\(totalPrice)")
    }
    
    
    //Buttons
    @IBAction func orderButton(_ sender: UIButton, forEvent event: UIEvent) {
        guard let svc = storyboard?.instantiateViewController(identifier: "second_vc") as? SecondViewController else {
            return
        }
        present(svc, animated: true)
    }
    
    @IBAction func checkoutButton(_ sender: UIButton) {
        performSegue(withIdentifier: "goSVC", sender: self)
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        cBurgerStepper.value = cBurgerStepper.minimumValue
        cBurgerResult.text = String("0")
        fBurgerStepper.value = fBurgerStepper.minimumValue
        fBurgerResult.text = String("0")
        floatStepper.value = floatStepper.minimumValue
        floatResult.text = String("0")
        sundaeStepper.value = sundaeStepper.minimumValue
        sundaeResult.text = String("0")
        spagStepper.value = spagStepper.minimumValue
        spagResult.text = String("0")
        tendersStepper.value = tendersStepper.minimumValue
        tendersResult.text = String("0")
    }
    
    @IBAction func resetsenderButton(_ sender: UIButton) {
        checkTotal((Any).self)
    }
}
