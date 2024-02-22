//
//  ViewController.swift
//  ValidateProject
//
//  Created by Abhang Mane @Goldmedal on 20/02/24.
//

import UIKit

class ValidateViewController: UIViewController {

    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var phoneValidLabel: UILabel!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var emailValidLabel: UILabel!
    
    var ValidColor = #colorLiteral(red: 0, green: 0.6901960784, blue: 0.4196078431, alpha: 1)
    var InvalidColor = #colorLiteral(red: 0.6901960784, green: 0.1831713362, blue: 0.05363970902, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        phoneValidLabel.isHidden = true
        emailValidLabel.isHidden = true
        phoneTextField.delegate = self
        emailTextField.delegate = self
    }

    @IBAction func checkPressed(_ sender: UIButton) {
        let phoneEntered = phoneTextField.text!
        let emailEntered = emailTextField.text!
        validateCredentials(validationType: "email", inputText: emailEntered)
        validateCredentials(validationType: "phone", inputText: phoneEntered)
    }
    
    func validateCredentials(validationType:String,inputText:String){
        switch validationType{
        case "email":
        if inputText != ""{
            let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            let emailValidateResult = emailTest.evaluate(with: inputText)
            print(emailValidateResult)
            if emailValidateResult == true {
                emailValidLabel.isHidden = false
                emailValidLabel.text = "Valid email"
                emailValidLabel.textColor = ValidColor
            }
            else{
                emailValidLabel.isHidden = false
                emailValidLabel.text = "Invalid email"
                emailValidLabel.textColor = InvalidColor
            }
            
        }
        else{
            emailValidLabel.isHidden = true
        }
        
        case "phone":
        if inputText != ""{
            let phoneRegEx = #"^[6-9]\d{9}$"#
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
            let phoneValidateResult = phoneTest.evaluate(with: inputText)
            print(phoneValidateResult)
            if phoneValidateResult == true {
                phoneValidLabel.isHidden = false
                phoneValidLabel.text = "Valid phone number"
                phoneValidLabel.textColor = ValidColor
            }
            else{
                phoneValidLabel.isHidden = false
                phoneValidLabel.text = "Invalid phone number"
                phoneValidLabel.textColor = InvalidColor
            }
        }
        else{
            phoneValidLabel.isHidden = true
        }
        default:
            return
        }
    }
}

extension ValidateViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let phoneEntered = phoneTextField.text!
        let emailEntered = emailTextField.text!
        validateCredentials(validationType: "email", inputText: emailEntered)
        validateCredentials(validationType: "phone", inputText: phoneEntered)
        if phoneEntered == ""{
        phoneValidLabel.isHidden = true
        }
        if emailEntered == ""{
        emailValidLabel.isHidden = true
        }
    }
}
