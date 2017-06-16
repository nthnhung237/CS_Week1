//
//  DetailTableViewCell.swift
//  Movies
//
//  Created by Nhung on 6/17/17.
//  Copyright © 2017 Long Nguyen. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbLike: UILabel!
    @IBOutlet weak var lbclock: UILabel!
    @IBOutlet weak var lbContend: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
