//
//  VCBuilder.swift
//  NewsFeed
//
//  Created by AndriiPp on 2/19/19.
//  Copyright © 2019 Andrii Pyvovarov. All rights reserved.
//

import UIKit

class VCBuilder {
    class func createMainVC() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MainIdent")
        return controller
    }
    class func createFilterVC() -> UIViewController {
        let storyboard = UIStoryboard(name: "Filter", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "FilterIdent")
        return controller
    }
}
