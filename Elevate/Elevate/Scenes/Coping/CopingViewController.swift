//
//  CopingViewController.swift
//  Elevate
//
//  Created by Nithya Arun on 4/1/21.
//

import UIKit
import FirebaseFirestore
import PKHUD

class General {
    
    var image: String?
    var name: String?
    
    init(image: String?, name: String?) {
        self.image = image
        self.name = name
    }
    
}

class CopingViewController: UIViewController {

    @IBOutlet weak var copingTableView: UITableView!
    
    var copingModel = [General(image: "leaf", name: "Meditation"), General(image: "wind", name: "Yoga"), General(image: "lungs", name: "Breathing"), General(image: "headphones", name: "Soothing sounds")]
    var copingSkillsModel: [String: [Video]] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar(title: "Coping")
        configureTableView()
        retrieveSkills()
        
    }
    
    func retrieveSkills() {
        let db = Firestore.firestore()
        let doc = db.collection("coping").document("skills")
        HUD.show(.progress)
        doc.getDocument { (snapshot, error) in
            if error != nil {
                print("there was an error")
                HUD.flash(.error)
                return
            }
            if let snapshot = snapshot, let data = snapshot.data() {
                for skill in data.keys {
                    if let skillArray = data[skill] as? [[String: String]] {
                        var array: [Video] = []
                        for video in skillArray {
                            let name = video["name"]
                            let thumbnail = video["thumbnail"]
                            let url = video["url"]
                            array.append(Video(videoTitle: name, thumbnail: thumbnail, url: url))
                        }
                        self.copingSkillsModel[skill] = array
                    }
                }
                
            }
            HUD.flash(.success)
        }
    }
    
    func configureTableView() {
        copingTableView.delegate = self
        copingTableView.dataSource = self
        copingTableView.register(UINib(nibName: "GeneralTableViewCell", bundle: nil), forCellReuseIdentifier: "GeneralTableViewCell")
    }
}

// MARK: TableViewDataSource
extension CopingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        copingModel.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GeneralTableViewCell", for: indexPath) as? GeneralTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setValues(model: copingModel[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let copingSkillModel = copingSkillsModel[copingModel[indexPath.row].name ?? ""] {
            let nextVC = CopingSkillsViewController()
            nextVC.title = copingModel[indexPath.row].name ?? ""
            nextVC.videosModel = copingSkillModel
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
}
