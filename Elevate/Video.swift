//
//  Video.swift
//  Elevate
//
//  Created by Nitya Babbar on 4/2/21.
//

import Foundation

class Video {
    var videoTitle: String?
    var picture: String?
    var url: String?
    
    init(videoTitle: String?, picture: String?, url: String?) {
        self.videoTitle = videoTitle
        self.picture = picture
        self.url = url
    }
}
