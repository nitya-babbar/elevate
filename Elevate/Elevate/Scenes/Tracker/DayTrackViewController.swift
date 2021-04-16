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
            return #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        case .sad:
            return #colorLiteral(red: 1, green: 0.4, blue: 0.4, alpha: 1)
        case .normal:
            return .systemYellow
        case .happy:
            return #colorLiteral(red: 0.4, green: 1, blue: 0.4, alpha: 1)
        case .veryHappy:
            return #colorLiteral(red: 0, green: 1, blue: 0, alpha: 1)
        }
    }
}

protocol DayTrackDelegate: class {
    func updatedDayTrack(dayTrack: DayTrack)
}

class DayTrackViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var smileyButtons: [UIButton]!
    @IBOutlet weak var journalTextView: UITextView!
    @IBOutlet weak var picker: UITextField!
    let thePicker = UIPickerView()
    weak var delegate: DayTrackDelegate?
    var dayTrack: DayTrack!
    var selectedMood: Mood!
    let myPickerData = [String](arrayLiteral: "1 Hour", "2 Hours", "3 Hours", "4 Hours", "5 Hours", "6 Hours", "7 Hours", "8 Hours", "9 Hours", "10 Hours", "11 Hours", "12 Hours", "13 Hours", "14 Hours", "15 Hours", "16 Hours", "17 Hours", "18 Hours", "19 Hours", "20 Hours")

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar(title: title)
        addCustomBack()
        if dayTrack != nil {
            smileyButtons[selectedMood.rawValue].isSelected = true
            smileyButtons[selectedMood.rawValue].tintColor = selectedMood.color()
            journalTextView.text = dayTrack.journal ?? ""
            picker.text = dayTrack.sleep ?? ""
        }
        picker.inputView = thePicker
        thePicker.delegate = self
    }
    
    func addCustomBack() {
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(checkIfCanGoBack))
        self.navigationItem.leftBarButtonItem = backButton

    }
    
    @objc func checkIfCanGoBack() {
        if selectedMood == nil {
            goBack()
            return
        }
        let newDayTrack = DayTrack(mood: self.selectedMood, journal: self.journalTextView.text, sleep: self.picker.text)
        if dayTrack != newDayTrack {
            let alert = UIAlertController(title: "Hey!", message: "Do you want to save your changes?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Save", style: .default) {_ in
                self.delegate?.updatedDayTrack(dayTrack: newDayTrack)
                self.goBack()
            })
            alert.addAction(UIAlertAction(title: "No", style: .default) {_ in
                self.goBack()
            })
            present(alert, animated: true, completion: nil)
        } else {
            goBack()
        }
        
    }
    
    func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func selectMood(_ sender: UIButton) {
        selectedMood = Mood(rawValue: sender.tag) ?? .normal
        moodColoring()
        
    }
    
    func moodColoring() {
        
        for i in 0 ..< 5 {
            
            if i == selectedMood.rawValue {
                smileyButtons[i].isSelected = true
                smileyButtons[i].tintColor = selectedMood.color()
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
