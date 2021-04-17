//
//  LongTermViewController.swift
//  Elevate
//
//  Created by Nithya Arun on 4/1/21.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import PKHUD

class LongTermGoalsViewController: UIViewController {
    
    @IBOutlet weak var longTermButton: UIButton!
    @IBOutlet weak var longTermGoalLabel: UILabel!
    @IBOutlet weak var longTermGoalTableView: UITableView!
    var uid: String?

    
    var longTermGoalModel: [Goal] = [Goal(description: "", done: false), Goal(description: "", done: false), Goal(description: "", done: false), Goal(description: "", done: false), Goal(description: "", done: false)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar(title: "Long Terms Goals")
        configureTableView()
        if let user = Auth.auth().currentUser {
            uid = user.uid
            HUD.show(.progress)
            retrieveGoals()
        }
    }
    // This function works to goback a presented viewController with modal option
//    @IBAction func goback(sender: UIButton) {
//
//        dismiss(animated: true, completion: nil)
//
//    }
    func configureTableView() {
        longTermGoalTableView.delegate = self
        longTermGoalTableView.dataSource = self
        longTermGoalTableView.register(UINib(nibName: "GoalsTableViewCell", bundle: nil), forCellReuseIdentifier: "GoalsTableViewCell")
    }
    
    func retrieveGoals() {
        let db = Firestore.firestore()
        let doc = db.document("users/\(uid ?? "")").collection("goals").document("longTermGoals")
        doc.getDocument { (snapshot, error) in
            if error != nil {
                print("there was an error")
                DispatchQueue.main.async {
                    HUD.flash(.error)
                }
                return
            }
            if let snapshot = snapshot, let data = snapshot.data(), let longTermGoals = data["longTermGoals"] as? [[String: Any]] {
                self.longTermGoalModel = []
                for longTermGoal in longTermGoals {
                    let description = longTermGoal["description"] as? String ?? ""
                    let done = longTermGoal["done"] as? Bool ?? false
                    self.longTermGoalModel.append(Goal(description: description, done: done))
                }
            }
            DispatchQueue.main.async {
                HUD.flash(.success)
                self.longTermGoalTableView.reloadData()
            }
        }

    }
    
    func saveGoals() {
        let db = Firestore.firestore()
        var array: [[String: Any]] = []
        for longTermGoal in longTermGoalModel {
            array.append(["description": longTermGoal.description ?? "", "done": longTermGoal.done ?? false])
        }
        db.document("users/\(uid ?? "")").collection("goals").document("longTermGoals").setData(["longTermGoals": array])
    }

}

extension LongTermGoalsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        longTermGoalModel.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GoalsTableViewCell", for: indexPath) as? GoalsTableViewCell else {
            return UITableViewCell()
        }
        
//        if let model = longTermGoalModel {
            cell.setValues(model: longTermGoalModel[indexPath.row], index: indexPath.row)
            cell.delegate = self
//        }
        
        return cell
        
    }
    
}

extension LongTermGoalsViewController: GoalsTableViewDelegate {
    func dailyGoalChanged(value: String, index: Int, done: Bool) {
        longTermGoalModel[index].description = value
        longTermGoalModel[index].done = done
        saveGoals()
    }
    
    func dailyGoalDoneChanged(done: Bool, index: Int) {
        longTermGoalModel[index].done = done
        saveGoals()
    }
    
}
