//
//  MainPageTableViewCell.swift
//  ASiC3Quiz2
//
//  Created by 陳冠華 on 2017/4/7.
//  Copyright © 2017年 my app. All rights reserved.
//

import UIKit

class MainPageTableViewCell: UITableViewCell {

    @IBOutlet weak var articleImage: UIImageView!

    @IBOutlet weak var articleTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    
        articleImage.layer.shadowPath =  UIBezierPath(rect: articleImage.bounds).cgPath
        articleImage.layer.cornerRadius = 8
//        articleImage.layer.masksToBounds = true
        articleImage.layer.borderWidth = 0.5
        articleImage.layer.shadowRadius = 8
        articleImage.layer.shadowColor = UIColor.black.cgColor
        articleImage.layer.shadowOpacity = 0.8
        articleImage.layer.shadowOffset = CGSize(width: 5, height: 5)
        
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
