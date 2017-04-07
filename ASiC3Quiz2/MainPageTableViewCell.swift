//
//  MainPageTableViewCell.swift
//  ASiC3Quiz2
//
//  Created by 陳冠華 on 2017/4/7.
//  Copyright © 2017年 my app. All rights reserved.
//

import UIKit

class MainPageTableViewCell: UITableViewCell {

    @IBOutlet weak var backGroundView: UIView!

    @IBOutlet weak var articleImage: UIImageView!

    @IBOutlet weak var articleTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        

        backGroundView.clipsToBounds = false
        backGroundView.layer.shadowColor = UIColor.black.cgColor
        backGroundView.layer.shadowOpacity = 1
        backGroundView.layer.shadowOffset = CGSize.zero
        backGroundView.layer.shadowRadius = 8
        backGroundView.layer.shadowPath = UIBezierPath(roundedRect: backGroundView.bounds, cornerRadius: 10).cgPath
        
        articleImage.layer.cornerRadius = 8
        articleImage.clipsToBounds = true
        articleImage.layer.borderWidth = 0.5


        
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
