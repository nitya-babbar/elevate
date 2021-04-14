//
//  TrackerViewController.swift
//  Elevate
//
//  Created by Rhonny Gonzalez on 4/7/21.
//

import UIKit
import FSCalendar

class TrackerViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
    
    @IBOutlet weak var calendar: FSCalendar!
    var dates: [String: Mood] = ["04/04/2021": Mood.verySad, "04/05/2021": Mood.sad, "04/06/2021": Mood.normal, "04/07/2021": Mood.happy, "04/08/2021": Mood.veryHappy]
    var selectedDate = Date()
    var shouldSelectNewOne = false
    
    fileprivate lazy var dateFormatter1: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tracker"
        calendar.allowsMultipleSelection = true
        for date in dates.keys {
            if let dateFormatted = dateFormatter1.date(from: date), dateFormatted <= calendar.maximumDate {
                calendar.select(dateFormatter1.date(from: date))
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if shouldSelectNewOne {
            calendar.reloadData()
            shouldSelectNewOne = false
        }
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        Date()
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        let key = dateFormatter1.string(from: date)
        if let mood = dates[key] {
            return mood.color()
        }
        return .blue
    }
    
    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        goToDate(date)
        return false
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        goToDate(date)
        return false
    }
    
    func goToDate(_ date: Date) {
        selectedDate = date
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .medium
        let dayTrackVC = DayTrackViewController()
        dayTrackVC.title = formatter1.string(from: date)
        let key = dateFormatter1.string(from: date)
        if let mood = dates[key] {
            dayTrackVC.selectedMood = mood
        }
        dayTrackVC.delegate = self
        navigationController?.pushViewController(dayTrackVC, animated: true)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TrackerViewController: DayTrackDelegate {
    func updatedSelectedMood(newMood: Mood) {
        calendar.select(selectedDate)
        let date = dateFormatter1.string(from: selectedDate)
        dates[date] = newMood
        shouldSelectNewOne = true
    }
}
