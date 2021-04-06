//
//  GeneralTableViewCell.swift
//  Elevate
//
//  Created by Rhonny Gonzalez on 4/5/21.
//

import UIKit

class GeneralTableViewCell: UITableViewCell {

    @IBOutlet weak var generalImageView: UIImageView!
    @IBOutlet weak var generalName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }
    
    func setValues(model: General) {
        generalImageView.image = UIImage(systemName: model.image ?? "")
        generalName.text = model.name
    }
    
}
