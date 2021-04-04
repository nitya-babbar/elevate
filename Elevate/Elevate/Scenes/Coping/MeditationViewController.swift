//
//  MeditationViewController.swift
//  Elevate
//
//  Created by Nitya Babbar on 4/2/21.
//

import UIKit

class MeditationViewController: UIViewController {
    @IBOutlet weak var videosCollectionView: UICollectionView!
    
    var videosModel = [Video(videoTitle: "Video 1", picture: "highlands", url: "https://www.youtube.com/watch?v=ZToicYcHIOU")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Meditation"
        configureCollectionView()
    }
    
    func configureCollectionView() {
        videosCollectionView.delegate = self
        videosCollectionView.dataSource = self
        videosCollectionView.register(UINib(nibName: "VideosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "VideosCollectionViewCell")
    }
}

extension MeditationViewController: UICollectionViewDelegate, UICollectionViewDataSource, VideosCollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        videosModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideosCollectionViewCell", for: indexPath) as? VideosCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.setValues(model: videosModel[indexPath.row])
        cell.delegate = self
        
        return cell
    }
}
