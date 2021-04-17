//
//  SignInViewController.swift
//  Elevate
//
//  Created by Rhonny Gonzalez on 4/3/21.
//

import UIKit
import FirebaseAuth
import PKHUD

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Sign In"
    }
    
    @IBAction func signInAction(_ sender: UIButton) {
        HUD.show(.progress)
        Auth.auth().signIn(withEmail: emailTextField.text ?? "", password: passwordTextField.text ?? "") { authResult, error in
            if let error = error {
                HUD.flash(.error)
                self.showAlert(with: "Error", message: error.localizedDescription)
            }
            DispatchQueue.main.async {
                HUD.flash(.success)
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    @IBAction func signUpAction(_ sender: UIButton) {
        navigationController?.pushViewController(SignUpViewController(), animated: true)
    }

}
