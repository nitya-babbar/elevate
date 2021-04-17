//
//  ViewController.swift
//  Elevate
//
//  Created by Nitya Babbar on 4/1/21.
//

import UIKit

extension UIViewController {
    
    func configureNavigationBar(title: String?, showPhone: Bool = true, showMessage: Bool = false) {
        self.title = title
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        var items: [UIBarButtonItem] = []

        if showMessage {
            let messageButton = UIBarButtonItem(image: UIImage(systemName: "message"), style: .plain, target: self, action: #selector(sendMessage))
            
            items.append(messageButton)
        }
        
        if showPhone {
            let search = UIBarButtonItem(image: UIImage(systemName: "phone"), style: .plain, target: self, action: #selector(emergencyCall))
//            search.imageInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
            items.append(search)
        }
        
        self.navigationItem.rightBarButtonItems = items
    }
    
    @objc func emergencyCall() {
        callNumber(phoneNumber: "8002738255")
    }
    
    private func callNumber(phoneNumber:String) {

      if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {

        let application:UIApplication = UIApplication.shared
        if (application.canOpenURL(phoneCallURL)) {
            application.open(phoneCallURL, options: [:], completionHandler: nil)
        }
      }
    }
    
    @objc func sendMessage() {
        print("Send message")
    }
    
    func showAlert(with title: String?, message: String?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true, completion: nil)
    }
    
}

