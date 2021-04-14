//
//  ViewController.swift
//  Elevate
//
//  Created by Nitya Babbar on 4/1/21.
//

import UIKit

extension UIViewController {
    
    func configureNavigationBar(title: String?, showPhone: Bool = true, showMessage: Bool = true) {
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
            search.imageInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
            items.append(search)
        }
        
        self.navigationItem.rightBarButtonItems = items
    }
    
    @objc func emergencyCall() {
        print("Call emergency number")
    }
    
    @objc func sendMessage() {
        print("Send message")
    }
    
}

