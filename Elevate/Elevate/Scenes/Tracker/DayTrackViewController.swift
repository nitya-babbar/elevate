//
//  DayTrackViewController.swift
//  Elevate
//
//  Created by Rhonny Gonzalez on 4/7/21.
//

import UIKit

enum Mood: Int {
    case verySad, sad, normal, happy, veryHappy
    
    func color() -> UIColor {
        switch self {
        case .verySad:
            return UIColor(red: 255, green: 0, blue: 0, alpha: 1)
        case .sad:
            return UIColor(red: 255, green: 102, blue: 102, alpha: 1)
        case .normal:
            return .systemYellow
        case .happy:
            return UIColor(red: 102, green: 255, blue: 102, alpha: 1)
        case .veryHappy:
            return UIColor(red: 0, green: 255, blue: 0, alpha: 1)
        }
    }
}

class DayTrackViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var smileyButtons: [UIButton]!
    @IBOutlet weak var picker: UITextField!
    let thePicker = UIPickerView()
    let myPickerData = [String](arrayLiteral: "1 Hour", "2 Hours", "3 Hours", "4 Hours", "5 Hours", "6 Hours", "7 Hours", "8 Hours", "9 Hours", "10 Hours", "11 Hours", "12 Hours", "13 Hours", "14 Hours", "15 Hours", "16 Hours", "17 Hours", "18 Hours", "19 Hours", "20 Hours")

    override func viewDidLoad() {
        super.viewDidLoad()

        picker.inputView = thePicker
        thePicker.delegate = self
    }
    
    
    @IBAction func selectMood(_ sender: UIButton) {
        
        moodColoring(Mood(rawValue: sender.tag) ?? .normal)
        
    }
    
    func moodColoring(_ mood: Mood) {
        
        for i in 0 ..< 5 {
            
            if i == mood.rawValue {
                smileyButtons[i].isSelected = true
                smileyButtons[i].tintColor = mood.color()
            } else {
                smileyButtons[i].isSelected = false
            }
            
            
        }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myPickerData.count
    }

    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myPickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        picker.text = myPickerData[row]
    }

    var pickerData: [String] = [String]()
}
