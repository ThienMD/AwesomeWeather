//
//  DateExt.swift
//  awsome-weather
//
//  Created by ThienMD on 1/5/20.
//  Copyright © 2020 ThienMD. All rights reserved.
//

import Foundation
extension Date {
    func string(with format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
