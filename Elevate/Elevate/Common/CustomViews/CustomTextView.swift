//
//  CustomTextView.swift
//  Elevate
//
//  Created by Rhonny Gonzalez on 4/12/21.
//

import UIKit

@IBDesignable
class CustomTextView: UITextView {
    
    @IBInspectable public var placeholder: String = "" {
        didSet {
            self.text = placeholder
        }
    }

    @IBInspectable public var placeholderColor: UIColor = .lightGray {
        didSet {
            self.textColor = placeholderColor
        }
    }
    
}
