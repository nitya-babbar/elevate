//
//  TrackerViewController.swift
//  Elevate
//
//  Created by Rhonny Gonzalez on 4/7/21.
//

import UIKit
import FSCalendar
import FirebaseAuth
import FirebaseFirestore

class DayTrack: Equatable {
    
    var mood: Mood
    var journal: String?
    var sleep: String?
    
    init(mood: Mood, journal: String?, sleep: String?) {
        self.mood = mood
        self.journal = journal
        self.sleep = sleep
    }
    
    static func ==(lhs: DayTrack, rhs: DayTrack) -> Bool {
        return lhs.mood == rhs.mood && lhs.journal == rhs.journal && lhs.sleep == rhs.sleep
    }
}



class TrackerViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
    
    @IBOutlet weak var calendar: FSCalendar!
    var dates: [String: DayTrack] = [:]
    var selectedDate = Date()
    var shouldSelectNewOne = false
    var uid: String?
    
    fileprivate lazy var dateFormatter1: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar(title: "Tracker")
        calendar.allowsMultipleSelection = true
        checkUserTracker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if shouldSelectNewOne {
            calendar.reloadData()
            shouldSelectNewOne = false
        }
    }
    
    func checkUserTracker() {
        if let user = Auth.auth().currentUser {
            uid = user.uid
            retrieveUserDayTrack()
        } else {
            //TODO: Add a send to login Logics
        }
    }
    
    func retrieveUserDayTrack() {
        let db = Firestore.firestore()
        let doc = db.document("users/\(uid ?? "")").collection("tracker")
        doc.getDocuments { (snapshot, error) in
            if error != nil {
                print("there was an error")
            }
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    if let mood = document["mood"] as? Int {
                        let journal = document["journal"] as? String
                        let sleep = document["sleep"] as? String
                        self.dates[document.documentID] = DayTrack(mood: Mood(rawValue: mood) ?? .normal, journal: journal, sleep: sleep)
                        self.selectARetrievedDate(date: document.documentID)
                    }
                }
            }
            self.calendar.reloadData()
        }
    }
    
    func saveUserDayTrack(key: String, dayTrack: DayTrack) {
        let db = Firestore.firestore()
        db.document("users/\(uid ?? "")").collection("tracker").document(key).setData(["mood": dayTrack.mood.rawValue,"journal": dayTrack.journal ?? "", "sleep": dayTrack.sleep ?? ""])
    }
    
    func selectARetrievedDate(date: String) {
        if let dateFormatted = dateFormatter1.date(from: date), dateFormatted <= calendar.maximumDate {
            calendar.select(dateFormatter1.date(from: date))
        }
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        Date()
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        let key = dateFormatter1.string(from: date)
        if let dayTrack = dates[key] {
            return dayTrack.mood.color()
        }
        return .blue
    }
    
    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        goToDate(date)
        return false
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        if uid == nil {
            showAlert(with: "Hey!", message: "You must sign in to use this feature")
            return false
        }
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
        if let dayTrack = dates[key] {
            dayTrackVC.dayTrack = dayTrack
            dayTrackVC.selectedMood = dayTrack.mood
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
    func updatedDayTrack(dayTrack: DayTrack) {
        calendar.select(selectedDate)
        let date = dateFormatter1.string(from: selectedDate)
        dates[date] = dayTrack
        saveUserDayTrack(key: date, dayTrack: dayTrack)
        shouldSelectNewOne = true
    }
}
