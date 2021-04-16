//
//  GoalsViewController.swift
//  Elevate
//
//  Created by Nitya Babbar on 4/1/21.
//

import UIKit
import FirebaseFirestore
class GoalsViewController: UIViewController {
    
    @IBOutlet weak var longTermButton: UIButton!
    @IBOutlet weak var todayGoalsLabel: UILabel!
    @IBOutlet weak var todayGoalsTableView: UITableView!
    
    
    var dailyGoalsModel = [Goal(description: "Daily Goal 1", done: false), Goal(description: "Daily Goal 2", done: false), Goal(description: "Daily Goal 3", done: false)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
//        let db = Firestore.firestore()
//        let dict: [String: Any] = ["Meditation": [["name": "video1","url":"www.youtube.com", "thumbnail": "youtubethumbail"], ["name": "video2","url":"www.youtube.com", "thumbnail": "youtubethumbail"], ["name": "video3","url":"www.youtube.com", "thumbnail": "youtubethumbail"], ["name": "video4","url":"www.youtube.com", "thumbnail": "youtubethumbail"], ["name": "video5","url":"www.youtube.com", "thumbnail": "youtubethumbail"], ["name": "video6","url":"www.youtube.com", "thumbnail": "youtubethumbail"]],
//                                   "Yoga": [["name": "video1","url":"www.youtube.com", "thumbnail": "youtubethumbail"], ["name": "video2","url":"www.youtube.com", "thumbnail": "youtubethumbail"], ["name": "video3","url":"www.youtube.com", "thumbnail": "youtubethumbail"], ["name": "video4","url":"www.youtube.com", "thumbnail": "youtubethumbail"], ["name": "video5","url":"www.youtube.com", "thumbnail": "youtubethumbail"], ["name": "video6","url":"www.youtube.com", "thumbnail": "youtubethumbail"]],
//                                   "Breathing": [["name": "video1","url":"www.youtube.com", "thumbnail": "youtubethumbail"], ["name": "video2","url":"www.youtube.com", "thumbnail": "youtubethumbail"], ["name": "video3","url":"www.youtube.com", "thumbnail": "youtubethumbail"], ["name": "video4","url":"www.youtube.com", "thumbnail": "youtubethumbail"], ["name": "video5","url":"www.youtube.com", "thumbnail": "youtubethumbail"], ["name": "video6","url":"www.youtube.com", "thumbnail": "youtubethumbail"]],
//                                   "Soothing sounds": [["name": "video1","url":"www.youtube.com", "thumbnail": "youtubethumbail"], ["name": "video2","url":"www.youtube.com", "thumbnail": "youtubethumbail"], ["name": "video3","url":"www.youtube.com", "thumbnail": "youtubethumbail"], ["name": "video4","url":"www.youtube.com", "thumbnail": "youtubethumbail"], ["name": "video5","url":"www.youtube.com", "thumbnail": "youtubethumbail"], ["name": "video6","url":"www.youtube.com", "thumbnail": "youtubethumbail"]]]
//        db.collection("coping").document("skills").setData(dict)
        let db = Firestore.firestore()
//        db.collection("users").document("zcqsla1HyHMmiltuIqpQSPPSBxJ2").collection("goals").document("longTermGoals").setData(["longTermGoals": [["description": "Learn a Piano song", "check": false], ["description": "Sing like Taylor Swift", "check": false], ["description": "Register in Dancing Lessons", "check": false]]])
        
        let doc = db.document("users/zcqsla1HyHMmiltuIqpQSPPSBxJ2").collection("tracker")
        doc.getDocuments { (snapshot, error) in
            if error != nil {
                print("there was an error")
            }
            if let snapshot = snapshot {
                dump(snapshot)
            }
        }
        
        configureNavigationBar(title: "Goals")
    }
    
    @IBAction func longTermsGoal(_ sender: UIButton) {
        
        navigationController?.pushViewController(LongTermGoalsViewController(), animated: true)
        //modal presentation style
//        let longTerms = LongTermGoalsViewController()
//        longTerms.modalPresentationStyle = .overFullScreen
//        longTerms.modalTransitionStyle = .crossDissolve
//
//        present(longTerms, animated: true, completion: nil)
    }
    
    func configureTableView() {
        todayGoalsTableView.delegate = self
        todayGoalsTableView.dataSource = self
        todayGoalsTableView.register(UINib(nibName: "GoalsTableViewCell", bundle: nil), forCellReuseIdentifier: "GoalsTableViewCell")
    }

}

// MARK: TableViewDataSource
extension GoalsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dailyGoalsModel.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GoalsTableViewCell", for: indexPath) as? GoalsTableViewCell else {
            return UITableViewCell()
        }
        
//        if let model = dailyGoalsModel {
            cell.setValues(model: dailyGoalsModel[indexPath.row], index: indexPath.row)
            cell.delegate = self
//        }
        
        return cell
        
    }
    
}

// MARK: GoalsTableViewDelegate
extension GoalsViewController: GoalsTableViewDelegate {
    
    func dailyGoalChanged(value: String, index: Int) {
        dailyGoalsModel[index].description = value
    }
    
}
