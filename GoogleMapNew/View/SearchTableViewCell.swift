//
//  SearchTableViewCell.swift
//  GoogleMapNew
//
//  Created by Sheng-Yu on 2022/11/7.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var shopNameLabel: UILabel!
    
    @IBOutlet weak var shopAddressLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
