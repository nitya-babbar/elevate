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
    func dailyGoalChanged(value: String, index: Int)
}

class GoalsTableViewCell: UITableViewCell, UITextViewDelegate {

    @IBOutlet weak var dailyTextView: UITextView!
    @IBOutlet weak var checkButton: UIButton!
    var index: Int?
    var delegate: GoalsTableViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setValues(model: Goal, index: Int) {
        
        dailyTextView.text = model.description ?? ""
        dailyTextView.delegate = self
        checkButton.isSelected = model.done ?? false
        self.index = index
    }
    
    @IBAction func checkAction(sender: UIButton) {
        checkButton.isSelected = !checkButton.isSelected
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if let index = index {
            delegate?.dailyGoalChanged(value: textView.text, index: index)
        }
    }
}
