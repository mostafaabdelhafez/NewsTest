//
//  ArticleHeader.swift
//  NewsApp
//
//  Created by Mostafa on 2/4/22.
//

import UIKit

class ArticleHeader: UITableViewHeaderFooterView {
    let articleImage:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubview(articleImage)
        articleImage.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        articleImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        articleImage.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        articleImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
