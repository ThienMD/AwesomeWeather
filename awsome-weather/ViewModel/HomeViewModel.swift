//
//  HomeViewModel.swift
//  awsome-weather
//
//  Created by ThienMD on 1/3/20.
//  Copyright © 2020 ThienMD. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import CoreLocation

class HomeViewModel: BaseViewModel {
    let disposeBag = DisposeBag()
    let locationManager = LocationManager()

    var coordinate: CLLocationCoordinate2D?
    private let weatherDataBehavior = BehaviorRelay(value: WeatherResponse())
    var weatherData: Observable<WeatherResponse> {
        return weatherDataBehavior.asObservable()
    }

    private let weatherForeCastListBehavior = BehaviorRelay(value: [WeatherResponse]())
    var weatherForeCastData: Observable<[WeatherResponse]> {
        return weatherForeCastListBehavior.asObservable()
    }

    func getInitialData() {

        locationManager.request {
            if let location = $0 {
                print("location = \(location.coordinate.latitude) \(location.coordinate.longitude)")
                self.coordinate = location.coordinate
                self.getWeather()
                self.getListWeatherForecast()
            } else {
                print("Get Location failed \(self.locationManager.didFailWithError)")
                return
            }
        }

    }

    func getWeather() {
        self.loadInProgressBehavior.accept(true)
        weatherNetworkManager.getWeather(with: coordinate!.latitude, lon: coordinate!.longitude)
            .subscribe(onSuccess: { jsonPosts in
                self.loadInProgressBehavior.accept(false)
                // we fetched the posts
                print(jsonPosts)
                self.weatherDataBehavior.accept(jsonPosts)
                //                               observer(.completed)
            }, onError: { error in
                // there was an error fetching the posts
                self.loadInProgressBehavior.accept(false)
                print(error)
            })
            .disposed(by: disposeBag)

    }

    func getListWeatherForecast() {
        self.loadInProgressBehavior.accept(true)
        weatherNetworkManager.getListWeatherForecast(with: coordinate!.latitude, lon: coordinate!.longitude)
            .subscribe(onSuccess: { jsonPosts in
                self.loadInProgressBehavior.accept(false)
                // we fetched the posts
                print(jsonPosts)
                self.weatherForeCastListBehavior.accept(jsonPosts.list)
                //                               observer(.completed)
            }, onError: { error in
                // there was an error fetching the posts
                self.loadInProgressBehavior.accept(false)
                print(error)
            })
            .disposed(by: disposeBag)

    }
}
