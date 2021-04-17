//
//  VideosCollectionViewCell.swift
//  Elevate
//
//  Created by Nitya Babbar on 4/2/21.
//

import UIKit

protocol VideosCollectionViewDelegate {}

class VideosCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    var delegate: VideosCollectionViewDelegate?
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
    
    func setValues(model: Video) {
        label.text = model.videoTitle ?? ""
    }
}
