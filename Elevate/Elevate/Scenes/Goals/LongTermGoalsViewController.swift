//
//  LongTermViewController.swift
//  Elevate
//
//  Created by Nithya Arun on 4/1/21.
//

import UIKit

class LongTermGoalsViewController: UIViewController {
    
    @IBOutlet weak var longTermButton: UIButton!
    @IBOutlet weak var longTermGoalLabel: UILabel!
    @IBOutlet weak var longTermGoalTableView: UITableView!
    
    
    var longTermGoalModel = [Goal(description: "Long Term Goal 1", done: false), Goal(description: "Long Term Goal 2", done: false), Goal(description: "Long Term Goal 3", done: false), Goal(description: "Long Term Goal 4", done: false), Goal(description: "Long Term Goal 5", done: false)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar(title: "Long Terms Goals")
        configureTableView()
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
    
    func dailyGoalChanged(value: String, index: Int) {
        longTermGoalModel[index].description = value
    }
    
}
