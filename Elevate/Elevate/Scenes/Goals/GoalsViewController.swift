//
//  GoalsViewController.swift
//  Elevate
//
//  Created by Nitya Babbar on 4/1/21.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import PKHUD

class GoalsViewController: UIViewController {
    
    @IBOutlet weak var longTermButton: UIButton!
    @IBOutlet weak var todayGoalsLabel: UILabel!
    @IBOutlet weak var todayGoalsTableView: UITableView!
    var auth = Auth.auth()
    var uid: String?
    
    var dailyGoalsModel: [Goal] = [Goal(description: "", done: false), Goal(description: "", done: false), Goal(description: "", done: false)]
    
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
//
//        let doc = db.document("users/zcqsla1HyHMmiltuIqpQSPPSBxJ2").collection("tracker")
//        doc.getDocuments { (snapshot, error) in
//            if error != nil {
//                print("there was an error")
//            }
//            if let snapshot = snapshot {
//                dump(snapshot)
//            }
//        }
        if let user = auth.currentUser {
            uid = user.uid
            retrieveGoals()
        }
        authListener()
        configureNavigationBar(title: "Goals")
    }
    
    func authListener() {
        auth.addStateDidChangeListener { (auth, user) in
            self.uid = user?.uid
            if user?.uid != nil {
                self.retrieveGoals()
            } else {
                self.dailyGoalsModel = [Goal(description: "", done: false), Goal(description: "", done: false), Goal(description: "", done: false)]
                DispatchQueue.main.async {
                    self.todayGoalsTableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func longTermsGoal(_ sender: UIButton) {
        
        navigationController?.pushViewController(LongTermGoalsViewController(), animated: true)

    }
    
    func configureTableView() {
        todayGoalsTableView.delegate = self
        todayGoalsTableView.dataSource = self
        todayGoalsTableView.register(UINib(nibName: "GoalsTableViewCell", bundle: nil), forCellReuseIdentifier: "GoalsTableViewCell")
    }
    
    func retrieveGoals() {
        HUD.show(.progress)
        let db = Firestore.firestore()
        let doc = db.document("users/\(uid ?? "")").collection("goals").document("dailyGoals")
        doc.getDocument { (snapshot, error) in
            
            if error != nil {
                print("there was an error")
                DispatchQueue.main.async {
                    HUD.flash(.error)
                }
                return
            }
            if let snapshot = snapshot, let data = snapshot.data(), let dailyGoals = data["dailyGoals"] as? [[String: Any]] {
                self.dailyGoalsModel = []
                for dailyGoal in dailyGoals {
                    let description = dailyGoal["description"] as? String ?? ""
                    let done = dailyGoal["done"] as? Bool ?? false
                    self.dailyGoalsModel.append(Goal(description: description, done: done))
                }
            }
            DispatchQueue.main.async {
                HUD.flash(.success)
                self.todayGoalsTableView.reloadData()
            }
        }

    }
    
    func saveGoals() {
        if let uid = uid {
            let db = Firestore.firestore()
            var array: [[String: Any]] = []
            for dailyGoal in dailyGoalsModel {
                array.append(["description": dailyGoal.description ?? "", "done": dailyGoal.done ?? false])
            }
            db.document("users/\(uid)").collection("goals").document("dailyGoals").setData(["dailyGoals": array])
        } else {
            showAlert(with: "Hey!", message: "You must be logged in to start adding your goals")
        }
        
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
        
            cell.setValues(model: dailyGoalsModel[indexPath.row], index: indexPath.row)
            cell.delegate = self
        
        return cell
        
    }
    
}

// MARK: GoalsTableViewDelegate
extension GoalsViewController: GoalsTableViewDelegate {    
    
    func dailyGoalChanged(value: String, index: Int, done: Bool) {
        dailyGoalsModel[index].description = value
        dailyGoalsModel[index].done = done
        saveGoals()
    }
    
    func dailyGoalDoneChanged(done: Bool, index: Int) {
        dailyGoalsModel[index].done = done
        saveGoals()
    }

    
}
