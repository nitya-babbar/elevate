//
//  GoalsViewController.swift
//  Elevate
//
//  Created by Nitya Babbar on 4/1/21.
//

import UIKit

class GoalsViewController: UIViewController {
    
    @IBOutlet weak var longTermButton: UIButton!
    @IBOutlet weak var todayGoalsLabel: UILabel!
    @IBOutlet weak var todayGoalsTableView: UITableView!
    
    
    var dailyGoalsModel = [Goal(description: "Daily Goal 1", done: false), Goal(description: "Daily Goal 2", done: false), Goal(description: "Daily Goal 3", done: false)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
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
