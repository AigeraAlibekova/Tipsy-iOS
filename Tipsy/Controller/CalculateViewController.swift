import UIKit

class CalculateViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var tenButton: UIButton!
    @IBOutlet weak var twentyButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tip = 0.1
    var numberOfPeople = 2
    var bill: Double? = 0.0
    var billPlusTip: Double = 0.0
    var result = "0.0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        billTextField.delegate = self
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Search"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) -> Bool {
        billTextField.endEditing(true)
        billTextField.endEditing(true)
        print(billTextField.text!)
        return true
    }
    @IBAction func tipChanged(_ sender: UIButton) {
        zeroButton.isSelected = false
        tenButton.isSelected = false
        twentyButton.isSelected = false
        
        sender.isSelected = true
        
        
        let buttonTitle = sender.currentTitle!
        
        let buttonTitleWithoutPercentSign = String(buttonTitle.dropLast())
        
        let buttonTitleToNumber = Double(buttonTitleWithoutPercentSign)!
        
        tip = buttonTitleToNumber / 100
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        numberOfPeople = Int(sender.value)
    }
    
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        bill = Double(billTextField.text ?? "0.00")
        billPlusTip = bill! * (tip + 1)
        result = String(format: "%.2f", billPlusTip / Double(numberOfPeople))
        print(result)
        
        performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.result = result
            destinationVC.tip = Int(tip*100)
            destinationVC.numberOfPeople = numberOfPeople
        }
    }
    
}

