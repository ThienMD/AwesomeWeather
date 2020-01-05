//
//  WeatherService.swift
//  awsome-weather
//
//  Created by ThienMD on 1/4/20.
//  Copyright © 2020 ThienMD. All rights reserved.
//

import Moya

let apiKey = "df29311bdc0fb205768405bd65a49562"

enum WeatherService {
    case getWeather(lat: Double, long: Double)
    case getListWeatherForecast(lat: Double, long: Double)
    case searchLocation(id: Double)
}

extension WeatherService: TargetType {

    // This is the base URL we'll be using, typically our server.
    var baseURL: URL {
        return URL(string: "https://api.openweathermap.org/data/2.5")!
    }

    // This is the path of each operation that will be appended to our base URL.
    var path: String {
        switch self {
        case .getWeather:
            return "/weather"
        case .getListWeatherForecast:
            return "/forecast"
        case .searchLocation:
            return "/posts"
        }
    }

    // Here we specify which method our calls should use.
    var method: Method {
        switch self {
        case .getWeather:
            return .get
        case .getListWeatherForecast:
            return .get
        case .searchLocation:
            return .delete
        }
    }

    // Here we specify body parameters, objects, files etc.
    // or just do a plain request without a body.
    // In this example we will not pass anything in the body of the request.
    var task: Task {
        switch self {
        case let .getWeather(lat, lon):
            let parameters: [String: Any] = ["lat": lat, "lon": lon, "APPID": apiKey]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case let .getListWeatherForecast(lat, lon):
            let parameters: [String: Any] = ["lat": lat, "lon": lon, "APPID": apiKey]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .searchLocation(let id):
            return .requestPlain
        }
    }

    // These are the headers that our service requires.
    // Usually you would pass auth tokens here.
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }

    // This is sample return data that you can use to mock and test your services,
    // but we won't be covering this.
    var sampleData: Data {
        return Data()
    }

}
