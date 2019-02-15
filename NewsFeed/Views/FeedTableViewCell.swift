//
//  FeedTableViewCell.swift
//  NewsFeed
//
//  Created by Andrii Pyvovarov on 2/14/19.
//  Copyright © 2019 Andrii Pyvovarov. All rights reserved.
//

import UIKit

class FeedTableViewCell : UITableViewCell {
    
    var  url : String?

//    var item : NewsPost! {
//        didSet {
//            url = item.url
//            title.text = item.title
//            source.text = item.source
//            author.text = item.author
//            descript.text = item.descript
//            dateOfPublication.text = item.publishedAt
//            profileImageView.downloadedForLink(from: item.imageUrl)
//
//        }
//    }
    
    let title : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let source : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let author : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let profileImageView: CustomImageView = {
        let imageV = CustomImageView()
        imageV.translatesAutoresizingMaskIntoConstraints = false
        imageV.layer.cornerRadius = 5
        imageV.layer.masksToBounds = true
        imageV.contentMode = .scaleAspectFill
        return imageV
    }()
    let descript : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.justified
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let dateOfPublication : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(title)
        addSubview(source)
        addSubview(author)
        addSubview(profileImageView)
        addSubview(descript)
        addSubview(dateOfPublication)
        
        
        title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        title.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        title.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        title.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        source.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        source.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        source.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8).isActive = true
        source.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        author.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        author.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        author.topAnchor.constraint(equalTo: source.bottomAnchor, constant: 8).isActive = true
        author.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
    
        profileImageView.topAnchor.constraint(equalTo: author.bottomAnchor, constant: 8).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        descript.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -26).isActive = true
        descript.topAnchor.constraint(equalTo:profileImageView.bottomAnchor, constant : 8).isActive = true
        descript.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        descript.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        dateOfPublication.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        dateOfPublication.topAnchor.constraint(equalTo: descript.bottomAnchor).isActive = true
        dateOfPublication.heightAnchor.constraint(equalToConstant: 18).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
