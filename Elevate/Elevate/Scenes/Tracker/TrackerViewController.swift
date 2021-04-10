//
//  TrackerViewController.swift
//  Elevate
//
//  Created by Rhonny Gonzalez on 4/7/21.
//

import UIKit
import FSCalendar

class TrackerViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate {
    
    @IBOutlet weak var calendar: FSCalendar!
    let dates: [String] = ["04/01/2021","04/03/2021","04/05/2021","04/07/2021","04/09/2021"]
    
    fileprivate lazy var dateFormatter1: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tracker"
        calendar.allowsMultipleSelection = true
        for i in 0 ..< dates.count {
            calendar.select(dateFormatter1.date(from: dates[i]))
            
        }

    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        Date()
    }
    
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(date)
        if dates.contains(dateFormatter1.string(from: date)) {
            cell.preferredFillSelectionColor = .systemGreen
        }
        
    }

    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(date)
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
