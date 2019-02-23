//
//  FilterViewController.swift
//  NewsFeed
//
//  Created by AndriiPp on 2/19/19.
//  Copyright © 2019 Andrii Pyvovarov. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var category: UILabel!
    static var countryString : String?
    static var categoryString : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar()
    }
    private func navBar(){
        navigationItem.title = "News Feed"
        let nav = self.navigationController?.navigationBar
        nav?.barTintColor = UIColor(r: 32, g: 72, b: 122)
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(r: 220, g: 240, b: 44), NSAttributedString.Key.font: UIFont(name: "CourierNewPS-BoldItalicMT", size: 24)!]
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(r: 220, g: 240, b: 44)
    }
    override func viewWillAppear(_ animated: Bool) {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "bg2")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    @IBAction func ruButton(_ sender: Any) {
        FilterViewController.countryString = "ru"
    }
    
    @IBAction func usButton(_ sender: Any) {
        FilterViewController.countryString = "us"
    }
    @IBAction func uaButton(_ sender: Any) {
        FilterViewController.countryString = "ua"
    }
    
    @IBAction func generalButton(_ sender: Any) {
        FilterViewController.categoryString = "general"
    }
    @IBAction func scienceButton(_ sender: Any) {
        FilterViewController.categoryString = "science"
    }
    
    @IBAction func sportsButton(_ sender: Any) {
        FilterViewController.categoryString = "sports"
    }
    @IBAction func doneButton(_ sender: Any) {
        if ((FilterViewController.categoryString != nil)&&(FilterViewController.countryString != nil)) {
            weak var mainVC = (VCBuilder.createMainVC()) as? MainViewController
            self.navigationController?.pushViewController(mainVC!, animated: true)
            
        }
    }
}
