//
//  Video.swift
//  Elevate
//
//  Created by Nitya Babbar on 4/2/21.
//

import Foundation

class Video {
    var videoTitle: String?
    var thumbnail: String?
    var url: String?
    
    init(videoTitle: String?, thumbnail: String?, url: String?) {
        self.videoTitle = videoTitle
        self.thumbnail = thumbnail
        self.url = url
    }
}
