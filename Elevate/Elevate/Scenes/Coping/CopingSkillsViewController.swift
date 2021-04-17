//
//  CopingSkillsViewController.swift
//  Elevate
//
//  Created by Nitya Babbar on 4/2/21.
//

import UIKit

class CopingSkillsViewController: UIViewController {
    @IBOutlet weak var videosCollectionView: UICollectionView!
    
    var videosModel: [Video] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar(title: title)
        configureCollectionView()
    }
    
    func configureCollectionView() {
        videosCollectionView.delegate = self
        videosCollectionView.dataSource = self
        videosCollectionView.register(UINib(nibName: "VideosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "VideosCollectionViewCell")
    }
}

extension CopingSkillsViewController: UICollectionViewDelegate, UICollectionViewDataSource, VideosCollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        videosModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideosCollectionViewCell", for: indexPath) as? VideosCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.setValues(model: videosModel[indexPath.row])
        cell.bgView.backgroundColor = coloring(index: indexPath.row)
        cell.delegate = self
        
        return cell
    }
    
    func coloring(index: Int) -> UIColor {
        
        return .blue
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let urlString = videosModel[indexPath.row].url, let url = URL(string: urlString) {
            let playerVC = PlayerViewController()
            playerVC.url = url
            navigationController?.pushViewController(playerVC, animated: true)
        }
    }
}

extension CopingSkillsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
   
            let width = (collectionView.bounds.width / 2) - 10
            let height = (width)
           
        return CGSize(width: width, height: height)
    }
}
