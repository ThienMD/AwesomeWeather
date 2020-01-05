//
//  UIViewExt.swift
//  awsome-weather
//
//  Created by ThienMD on 1/3/20.
//  Copyright © 2020 ThienMD. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    func addBackgroundImage() {
        let backgroundImage = UIImageView(frame: self.bounds)
        backgroundImage.image = #imageLiteral(resourceName: "background")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.insertSubview(backgroundImage, at: 0)

    }
}
