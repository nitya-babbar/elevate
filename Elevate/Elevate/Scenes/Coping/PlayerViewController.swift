//
//  PlayerViewController.swift
//  Elevate
//
//  Created by Rhonny Gonzalez on 4/13/21.
//

import UIKit
import YouTubePlayer

class PlayerViewController: UIViewController {

    @IBOutlet weak var player: YouTubePlayerView!
    var url: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        player.loadVideoURL(url)
        player.delegate = self
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PlayerViewController: YouTubePlayerDelegate {
    
    func playerReady(_ videoPlayer: YouTubePlayerView) {
        player.play()
    }
    
}
