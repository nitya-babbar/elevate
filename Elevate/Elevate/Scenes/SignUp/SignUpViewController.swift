//
//  SignUpViewController.swift
//  Elevate
//
//  Created by Rhonny Gonzalez on 4/3/21.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

//    @IBOutlet weak var usernameTextField: UITextField!
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
        
//        if usernameTextField.text?.count ?? 0 < 4 {
//            return (false, "username should have more than 3 characters")
//        }
        
        if passwordTextField.text != passwordConfirmTextField.text {
            return (false, "Password confirmation should match with your password field")
        }
        
        return (true, "")
    }
    
    func showAlert(with title: String?, message: String?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true, completion: nil)
    }

    
    @IBAction func signUpAction(_ sender: UIButton) {
        
        let validForm = isValidForm()
        Auth.auth().createUser(withEmail: emailTextField.text ?? "", password: passwordTextField.text ?? "") { authResult, error in
            if let error = error {
                self.showAlert(with: "Error", message: error.localizedDescription)
            }
            dump(authResult)
            self.showAlert(with: "Success", message: "User Created")
        }
        if validForm.isValid {
            
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
        
        if textField == emailTextField, !(emailTextField.text ?? "").isValidEmail() {
            textField.becomeFirstResponder()
            showAlert(with: "Error", message: "This is not a valid Email")
        }
        
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
