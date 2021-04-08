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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tracker"

    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        Date()
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
