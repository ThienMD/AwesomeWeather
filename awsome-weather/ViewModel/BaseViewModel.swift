//
//  BaseViewModel.swift
//  awsome-weather
//
//  Created by ThienMD on 1/4/20.
//  Copyright © 2020 ThienMD. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class BaseViewModel {
    let weatherNetworkManager: WeatherNetworkManager = WeatherNetworkManager.shared
    var onShowLoadingHud: Observable<Bool> {
        return loadInProgressBehavior
            .asObservable()
            .distinctUntilChanged()
    }
    internal let loadInProgressBehavior = BehaviorRelay(value: false)

}
