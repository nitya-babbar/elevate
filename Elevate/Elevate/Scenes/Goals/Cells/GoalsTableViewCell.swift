//
//  GoalsTableViewCell.swift
//  Elevate
//
//  Created by Rhonny Gonzalez on 4/1/21.
//

import UIKit

class Goal {
    var description: String?
    var done: Bool?
    
    init(description: String?, done: Bool?) {
        self.description = description
        self.done = done
    }
}

protocol GoalsTableViewDelegate {
    func dailyGoalChanged(value: String, index: Int, done: Bool)
    func dailyGoalDoneChanged(done: Bool, index: Int)
}

class GoalsTableViewCell: UITableViewCell {

    @IBOutlet weak var dailyTextView: CustomTextView!
    @IBOutlet weak var checkButton: UIButton!
    var index: Int?
    var delegate: GoalsTableViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none

    }
    
    func setValues(model: Goal, index: Int) {
        if model.description != "" {
            dailyTextView.text = model.description
            dailyTextView.textColor = .black
        }
        dailyTextView.customDelegate = self
        checkButton.isSelected = model.done ?? false
        self.index = index
    }
    
    @IBAction func checkAction(sender: UIButton) {
        if !dailyTextView.text.isEmpty && dailyTextView.text != dailyTextView.placeholder {
            checkButton.isSelected = !checkButton.isSelected
            if let index = index {
                delegate?.dailyGoalDoneChanged(done: checkButton.isSelected, index: index)
            }
        }
    }
    
//    func textViewDidChange(_ textView: UITextView) {
//        if let index = index {
//            delegate?.dailyGoalChanged(value: textView.text, index: index)
//        }
//    }
}

extension GoalsTableViewCell: CustomTextViewDelegate {
    func customTextViewDidChange(_ textView: UITextView) {
        if let index = index {
            if textView.text.isEmpty || textView.text == dailyTextView.placeholder {
                checkButton.isSelected = false
            }
            delegate?.dailyGoalChanged(value: textView.text, index: index, done: checkButton.isSelected)
        }
    }
}
