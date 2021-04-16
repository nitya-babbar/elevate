//
//  SettingsViewController.swift
//  Elevate
//
//  Created by Rhonny Gonzalez on 4/5/21.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

enum About: String {
    case premium = "Be premium"
    case about = "About"
    case signIn = "Sign In"
    case signOut = "Sign out"
}

class SettingsViewController: UIViewController {

    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var settingsTableView: UITableView!
    
    var settingsModel: [General] = []
    var isLoggedIn = true
    var isFirstTime = true
    var auth = Auth.auth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar(title: "Settings")
        checkIfUserLoggedIn()
        authListener()
        configureTableView()
    }
    
    func checkIfUserLoggedIn() {
        if let _ = auth.currentUser {
            isLoggedIn = true
        } else {
            isLoggedIn = false
        }
        configureModel()
    }
    
    func authListener() {
        auth.addStateDidChangeListener { (auth, user) in
            if user != nil {
                self.isLoggedIn = true
            } else {
                self.isLoggedIn = false
            }
            self.configureModel()
            DispatchQueue.main.async {
                self.settingsTableView.reloadData()
            }
        }
    }
    
    func configureModel() {
        if !isLoggedIn {
            userLabel.isHidden = true
            settingsModel = [General(image: "questionmark.circle", name: "About"), General(image: "person.circle", name: "Sign In")]
            return
        }
        userLabel.isHidden = false
        let db = Firestore.firestore()
        let doc = db.document("users/\(auth.currentUser?.uid ?? "")")
        doc.getDocument { (snapshot, error) in
            if let snapshot = snapshot, let data = snapshot.data(), let firstname = data["firstname"] as? String {
                DispatchQueue.main.async {
                    self.userLabel.text = "Hello, \(firstname)"
                }
            }
        }
        settingsModel = [General(image: "star", name: "Be premium"), General(image: "questionmark.circle", name: "About"), General(image: "figure.walk", name: "Sign out")]
    }
    
    func configureTableView() {
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        settingsTableView.register(UINib(nibName: "GeneralTableViewCell", bundle: nil), forCellReuseIdentifier: "GeneralTableViewCell")
    }


}

// MARK: TableViewDataSource
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = settingsModel.count
        return count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GeneralTableViewCell", for: indexPath) as? GeneralTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setValues(model: settingsModel[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var nextVC: UIViewController?
        switch About.init(rawValue: settingsModel[indexPath.row].name ?? "") {
        case .premium:
            break
        case .about:
            break
        case .signIn:
            nextVC = SignInViewController()
        case .signOut:
            do {
                try auth.signOut()
            } catch let signOutError as NSError {
              print ("Error signing out: %@", signOutError)
            }
        case .none:
            break
        }
        if let vc = nextVC {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
