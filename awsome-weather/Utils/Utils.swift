//
//  Utils.swift
//  awsome-weather
//
//  Created by ThienMD on 1/4/20.
//  Copyright © 2020 ThienMD. All rights reserved.
//

import Foundation

class Utils {
    class func convertKevinToCelsius(kevin: Double) -> String {
        return  String(format: "%.0f", kevin - 273.15)
    }
}
