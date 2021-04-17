//
//  CustomTextView.swift
//  Elevate
//
//  Created by Rhonny Gonzalez on 4/12/21.
//

import UIKit

protocol CustomTextViewDelegate: class {
    func customTextViewDidChange(_ textView: UITextView)
}

@IBDesignable
class CustomTextView: UITextView, UITextViewDelegate {
    
    weak var customDelegate: CustomTextViewDelegate?
    
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        if self.text == placeholder {
            self.textColor = placeholderColor
        }
        
    }
    func textViewDidChange(_ textView: UITextView) {
        if self.text != placeholder && self.textColor != placeholderColor {
            customDelegate?.customTextViewDidChange(textView)
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.text == placeholder && self.textColor == placeholderColor {
            self.text = nil
            self.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if self.text.trimmingCharacters(in: .whitespaces).isEmpty {
            self.text = placeholder
            self.textColor = placeholderColor
        }
    }
    
    
}
