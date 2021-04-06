//
//  CopingSkillsViewController.swift
//  Elevate
//
//  Created by Nitya Babbar on 4/2/21.
//

import UIKit

class CopingSkillsViewController: UIViewController {
    @IBOutlet weak var videosCollectionView: UICollectionView!
    
    var videosModel = [Video(videoTitle: "Video 1", picture: "highlands", url: "https://www.youtube.com/watch?v=ZToicYcHIOU"), Video(videoTitle: "Video 2", picture: "highlands", url: "https://www.youtube.com/watch?v=ZToicYcHIOU"), Video(videoTitle: "Video 3", picture: "highlands", url: "https://www.youtube.com/watch?v=ZToicYcHIOU"), Video(videoTitle: "Video 4", picture: "highlands", url: "https://www.youtube.com/watch?v=ZToicYcHIOU"), Video(videoTitle: "Video 1", picture: "highlands", url: "https://www.youtube.com/watch?v=ZToicYcHIOU"), Video(videoTitle: "Video 2", picture: "highlands", url: "https://www.youtube.com/watch?v=ZToicYcHIOU"), Video(videoTitle: "Video 3", picture: "highlands", url: "https://www.youtube.com/watch?v=ZToicYcHIOU"), Video(videoTitle: "Video 4", picture: "highlands", url: "https://www.youtube.com/watch?v=ZToicYcHIOU"), Video(videoTitle: "Video 1", picture: "highlands", url: "https://www.youtube.com/watch?v=ZToicYcHIOU"), Video(videoTitle: "Video 2", picture: "highlands", url: "https://www.youtube.com/watch?v=ZToicYcHIOU"), Video(videoTitle: "Video 3", picture: "highlands", url: "https://www.youtube.com/watch?v=ZToicYcHIOU"), Video(videoTitle: "Video 4", picture: "highlands", url: "https://www.youtube.com/watch?v=ZToicYcHIOU")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        cell.delegate = self
        
        return cell
    }
}

extension CopingSkillsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
   
            let width = (collectionView.bounds.width / 2) - 10
            let height = (width)
           
        return CGSize(width: width, height: height)
    }
}
