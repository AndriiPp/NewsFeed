//
//  imageViewExtension.swift
//  NewsFeed
//
//  Created by Andrii Pyvovarov on 2/15/19.
//  Copyright © 2019 Andrii Pyvovarov. All rights reserved.
//
import UIKit

extension UIColor{
    static func rgb(red : CGFloat, green : CGFloat, blue : CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

//let imageCashe = NSCache<AnyObject, AnyObject>()

class CustomImageView : UIImageView {
    

    func downloaded(from url: URL) {
       
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedForLink(from link: String) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url)
    }
}
