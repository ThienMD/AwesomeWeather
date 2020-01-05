//
//  ApiService.swift
//  awsome-weather
//
//  Created by ThienMD on 1/4/20.
//  Copyright © 2020 ThienMD. All rights reserved.
//

import RxSwift
import Moya

struct WeatherNetworkManager {
    // I'm using a singleton for the sake of demonstration and other lies I tell myself
    public static let shared = WeatherNetworkManager()
    // This is the provider for the service we defined earlier
    private let provider = MoyaProvider<WeatherService>()
    private init() {}

    // We're returning a Single response with just an array with the retrieved posts.
    // You could return an Observable<PostJSON> if you need to, this is just an example.
    func getWeather(with lat: Double, lon: Double) -> Single<WeatherResponse> {
        return provider.rx                              // we use the Reactive component for our provider
            .request(.getWeather(lat: lat, long: lon))                         // we specify the call
            .filterSuccessfulStatusAndRedirectCodes()
            .map(WeatherResponse.self)                       // we map the response to our Codable objects
    }

    func getListWeatherForecast(with lat: Double, lon: Double) -> Single<WeatherForecastResponse> {
        return provider.rx                              // we use the Reactive component for our provider
            .request(.getListWeatherForecast(lat: lat, long: lon))
            .filterSuccessfulStatusAndRedirectCodes()
            .map(WeatherForecastResponse.self)
    }
}
