//
//  SorceViewCell.swift
//  NewsUpdateApp
//
//  Created by Divya Pandit Chhetri on 6/13/18.
//  Copyright © 2018 Divya Pandit Chhetri. All rights reserved.
//

import UIKit

class SourceViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var sourceNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
