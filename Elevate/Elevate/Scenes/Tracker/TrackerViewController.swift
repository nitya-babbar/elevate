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
    let dates: [String: UIColor] = ["04/04/2021": Mood.verySad.color(), "04/05/2021": Mood.sad.color(), "04/06/2021": Mood.normal.color(), "04/07/2021": Mood.happy.color(), "04/08/2021": Mood.veryHappy.color()]
    
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
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        Date()
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        let key = dateFormatter1.string(from: date)
        if let color = dates[key] {
            return color
        }
        return .blue
    }
    
    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        goToDate(date)
        return false
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        goToDate(date)
    }
    
    func goToDate(_ date: Date) {
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .medium
        let dayTrackVC = DayTrackViewController()
        dayTrackVC.title = formatter1.string(from: date)
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
