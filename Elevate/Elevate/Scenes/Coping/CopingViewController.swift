//
//  CopingViewController.swift
//  Elevate
//
//  Created by Nithya Arun on 4/1/21.
//

import UIKit

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
    
    var copingModel = [General(image: "leaf", name: "Meditaion"), General(image: "wind", name: "Yoga"), General(image: "lungs", name: "Breathing"), General(image: "headphones", name: "Soothing sounds")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar(title: "Coping")
        configureTableView()
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
        let nextVC = CopingSkillsViewController()
        nextVC.title = copingModel[indexPath.row].name ?? ""
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
