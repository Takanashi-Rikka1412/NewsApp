//
//  CustomTableViewCell.swift
//  NewsApp
//
//  Created by Takanashi on 2021/5/19.
//  Copyright © 2021 Takanashi. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell
{
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsPassTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
