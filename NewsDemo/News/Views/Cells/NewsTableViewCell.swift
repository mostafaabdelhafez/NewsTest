//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Mostafa on 2/2/22.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var title:UILabel!
    @IBOutlet weak var details:UILabel!
    @IBOutlet weak var thumbnail:UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
