//
//  SignUpViewController.swift
//  Elevate
//
//  Created by Rhonny Gonzalez on 4/3/21.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import PKHUD

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create your account"
        disableSignUpButton()
        configureTextFields()
    }
    
    func configureTextFields() {
//        usernameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordConfirmTextField.delegate = self
    }
    
    func disableSignUpButton() {
        signUpButton.backgroundColor = .lightGray
        signUpButton.isEnabled = false
    }
    
    func enableSignUpButton() {
        signUpButton.backgroundColor = #colorLiteral(red: 0.7215686275, green: 0.9411764706, blue: 1, alpha: 1)
        signUpButton.isEnabled = true
    }

    func isValidForm() -> (isValid: Bool, message: String)  {
        
        if firstnameTextField.text?.count ?? 0 < 1 {
            return (false, "Firstname should not be empty")
        }
        
        if lastnameTextField.text?.count ?? 0 < 1 {
            return (false, "Lastname should not be empty")
        }
        
        if !(emailTextField?.text?.isValidEmail() ?? false) {
            return (false, "The email should be a valid email")
        }
        
        if passwordTextField.text != passwordConfirmTextField.text {
            return (false, "Password confirmation should match with your password field")
        }
        
        return (true, "")
    }
    
    @IBAction func signUpAction(_ sender: UIButton) {
        
        let validForm = isValidForm()
        
        if validForm.isValid {
            HUD.show(.progress)
            Auth.auth().createUser(withEmail: emailTextField.text ?? "", password: passwordTextField.text ?? "") { authResult, error in
                if let error = error {
                    HUD.flash(.error)
                    self.showAlert(with: "Error", message: error.localizedDescription)
                    return
                }
                if let uid = authResult?.user.uid {
                    let db = Firestore.firestore()
                    db.collection("users").document(uid).setData(["firstname": self.firstnameTextField?.text ?? "", "lastname": self.lastnameTextField?.text ?? "", "email": self.emailTextField?.text ?? "", "uid": uid])
                    DispatchQueue.main.async {
                        HUD.flash(.success)
                        self.navigationController?.popToRootViewController(animated: true)
                    }

                    //db.collection("users").document("9ugfFDcDFgSxV9kBWPYsVU0Qx4k1").collection("tracker").document("daytrack").setData(["04/10/2021":["mood": 4,"journal":"Today was a great day just hanging out with friends", "sleep": "8 hours"]])//setData(["firstname": "Rhonny", "lastname": "Gonzalez", "uid": uid])
                }
                
            }
        } else {
            showAlert(with: "Error", message: validForm.message)
        }
        
        
    }
    
}

extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if emailTextField.text != "" && passwordTextField.text != "" && passwordConfirmTextField.text != "" {
            enableSignUpButton()
        } else {
            disableSignUpButton()
        }
        
    }
    
}

extension String {
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
}
