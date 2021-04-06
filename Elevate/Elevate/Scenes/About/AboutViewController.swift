//
//  AboutViewController.swift
//  Elevate
//
//  Created by Rhonny Gonzalez on 4/5/21.
//

import UIKit

enum About: String {
    case premium = "Be premium"
    case about = "About"
    case signIn = "Sign In"
}

class AboutViewController: UIViewController {

    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var aboutTableView: UITableView!
    
    var aboutModel: [General] = []
    var isLoggedIn = true
    var isFirstTime = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "About"
        configureModel()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !isFirstTime {
            isLoggedIn = !isLoggedIn
            configureModel()
            aboutTableView.reloadData()
        }
        isFirstTime = false
    }
    
    func configureModel() {
        if !isLoggedIn {
            userLabel.isHidden = true
            aboutModel = [General(image: "questionmark.circle", name: "About"), General(image: "person.circle", name: "Sign In")]
            return
        }
        userLabel.isHidden = false
        userLabel.text = "Hello, user"
        aboutModel = [General(image: "star", name: "Be premium"), General(image: "questionmark.circle", name: "About")]
    }
    
    func configureTableView() {
        aboutTableView.delegate = self
        aboutTableView.dataSource = self
        aboutTableView.register(UINib(nibName: "GeneralTableViewCell", bundle: nil), forCellReuseIdentifier: "GeneralTableViewCell")
    }


}

// MARK: TableViewDataSource
extension AboutViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = aboutModel.count
        return count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GeneralTableViewCell", for: indexPath) as? GeneralTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setValues(model: aboutModel[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var nextVC: UIViewController?
        switch About.init(rawValue: aboutModel[indexPath.row].name ?? "") {
        case .premium:
            break
        case .about:
            break
        case .signIn:
            nextVC = SignInViewController()
        case .none:
            break
        }
        if let vc = nextVC {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
