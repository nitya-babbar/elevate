//
//  SignInViewController.swift
//  Elevate
//
//  Created by Rhonny Gonzalez on 4/3/21.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Sign In"
    }
    
    func showAlert(with title: String?, message: String?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func signInAction(_ sender: UIButton) {
        
        Auth.auth().signIn(withEmail: emailTextField.text ?? "", password: passwordTextField.text ?? "") { authResult, error in
            if let error = error {
                self.showAlert(with: "Error", message: error.localizedDescription)
            }
            dump(authResult)
            self.showAlert(with: "Success", message: "User Created")
        }
    }
    
    @IBAction func signUpAction(_ sender: UIButton) {
        navigationController?.pushViewController(SignUpViewController(), animated: true)
    }

}
