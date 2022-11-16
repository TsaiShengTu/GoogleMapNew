//
//  ShopDetailTableViewCell.swift
//  GoogleMapNew
//
//  Created by Sheng-Yu on 2022/11/7.
//

import UIKit

class ShopDetailTableViewCell: UITableViewCell {
    
    var reviews:Reviews!
    
    
    let listController = DataModel()
    
    //時間轉成字串
    var dateFormatter = DateFormatter()

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var ImagePhoto: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var timeAgoLabel: UILabel!
    
    @IBOutlet weak var commentTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateShopDetail(){
        if let reviews = reviews{
            listController.fetchPhoto(url: reviews.profilePhotoUrl) { image in
                DispatchQueue.main.async {
                    self.ImagePhoto.image = image
                }
            }
        }
        nameLabel.text = reviews.authorName
        timeAgoLabel.text = reviews.relativeTimeDescription
        commentTextView.text = reviews.text
//        shopTimeTextView.text = result.openingHours.weekdayText.compactMap({$0}).joined()
        
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        timeLabel.text = dateFormatter.string(from: reviews.time)
    }
    
}
