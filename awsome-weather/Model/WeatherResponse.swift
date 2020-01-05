// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation
let urlIcon = "https://openweathermap.org/img/wn/"
struct WeatherResponse {
    let place: String?
    let sunset: Date?
    let sunrise: Date?
    let icon: String
    let temp: String
    let tempMax: String?
    let tempMin: String?
    let feelsLike: String
    let humidity: Double
    let date: Date?
    let country: String?

    init() {
        place = ""
        sunset = nil
        sunrise = nil
        icon = ""
        temp = ""
        tempMax = ""
        tempMin = ""
        feelsLike = ""
        country = ""
        humidity = 0
        date = nil
    }

    enum CodingKeys: String, CodingKey {
        case place = "name"
        case sunset
        case sunrise
        case icon
        case temp
        case weather
        case date = "dt"
        case sys
        case main
    }

}

struct Weather: Codable {
    let id: Int
    let main: String
    let icon: String

    init() {
        id = 0
        main = ""
        icon = ""
    }
}

struct Sys: Decodable {
    let country: String?
    let sunrise: TimeInterval
    let sunset: TimeInterval

    init() {
        country = ""
        sunrise = 0
        sunset = 0
    }

    enum CodingKeys: String, CodingKey {
        case country
        case sunrise
        case sunset
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        sunrise = try values.decodeIfPresent(TimeInterval.self, forKey: .sunrise) ?? 0
        sunset = try values.decodeIfPresent(TimeInterval.self, forKey: .sunset) ?? 0
    }
}

struct MainObject: Codable {
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    let humidity: Double
    let feelsLike: Double

    init() {
        temp = 0
        tempMin = 0
        tempMax = 0
        humidity = 0
        feelsLike = 0
    }

    enum CodingKeys: String, CodingKey {
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case humidity
        case temp
        case feelsLike = "feels_like"
    }
}

extension WeatherResponse: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        place = try values.decodeIfPresent(String.self, forKey: .place)
        let mainObject = try values.decodeIfPresent(MainObject.self, forKey: .main) ?? MainObject()
        temp = Utils.convertKevinToCelsius(kevin: mainObject.temp)
        tempMax = Utils.convertKevinToCelsius(kevin: mainObject.tempMax)
        tempMin = Utils.convertKevinToCelsius(kevin: mainObject.tempMin)
        feelsLike = Utils.convertKevinToCelsius(kevin: mainObject.feelsLike)
        humidity = mainObject.humidity

        let weather = try values.decodeIfPresent(Array<Weather>.self, forKey: .weather) ?? [Weather]()
        let timestamp = try values.decode(TimeInterval.self, forKey: .date)
        date = Date(timeIntervalSince1970: timestamp)
        icon =  "\(urlIcon)\(weather[0].icon)@2x.png"

        let sys = try values.decodeIfPresent(Sys.self, forKey: .sys) ?? Sys()
        country = sys.country
        sunrise = Date(timeIntervalSince1970: sys.sunrise)
        sunset = Date(timeIntervalSince1970: sys.sunset)

    }
}
