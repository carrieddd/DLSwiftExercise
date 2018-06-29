//
//  DLDefaultCell.swift
//  LJGeographyFinance
//
//  Created by 董樑 on 2017/11/21.
//  Copyright © 2017年 dongl. All rights reserved.
//

import UIKit

class DLDefaultCell: UITableViewCell {

    @IBOutlet weak var labalLPadding: NSLayoutConstraint!
    @IBOutlet weak var imgR: UIImageView!
    @IBOutlet weak var imgL: UIImageView!
    @IBOutlet weak var labelL: UILabel!
    @IBOutlet weak var labelR: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
