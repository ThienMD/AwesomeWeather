//
//  WeatherByHourModel.swift
//  awsome-weather
//
//  Created by ThienMD on 1/4/20.
//  Copyright © 2020 ThienMD. All rights reserved.
//

import Foundation

struct WeatherForecastResponse: Decodable {
    let list: [WeatherResponse]

    init() {
        list = [WeatherResponse]()
    }
}
