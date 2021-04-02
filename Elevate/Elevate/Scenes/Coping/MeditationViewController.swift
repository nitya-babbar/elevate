//
//  MeditationViewController.swift
//  Elevate
//
//  Created by Nitya Babbar on 4/2/21.
//

import UIKit

class MeditationViewController: UIViewController {
    @IBOutlet weak var meditationCollectionView: UICollectionView!
    
    var videosModel = [Video(videoTitle: "", picture: ""), Video(videoTitle: "", picture: ""), Video(videoTitle: "Video 1", picture: "scribble")]
}
