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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "bg2")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    @IBAction func ruButton(_ sender: Any) {
    }
    
    @IBAction func usButton(_ sender: Any) {
    }
    @IBAction func uaButton(_ sender: Any) {
    }
    
    @IBAction func generalButton(_ sender: Any) {
    }
    @IBAction func scienceButton(_ sender: Any) {
    }
    
    @IBAction func sportsButton(_ sender: Any) {
    }
    @IBAction func doneButton(_ sender: Any) {
    }
}
