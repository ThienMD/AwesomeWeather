//
//  HomeViewController.swift
//  awsome-weather
//
//  Created by ThienMD on 1/3/20.
//  Copyright © 2020 ThienMD. All rights reserved.
//

import UIKit
import PKHUD
import RxSwift
import SDWebImage

class HomeViewController: UIViewController {
    let viewModel: HomeViewModel = HomeViewModel()
    let disposeBag = DisposeBag()

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var ivWeather: UIImageView!
    @IBOutlet weak var lblToday: UILabel!
    @IBOutlet weak var lblPlace: UILabel!
    @IBOutlet weak var lblTemperature: UILabel!
    @IBOutlet weak var lblFeelsLike: UILabel!
    @IBOutlet weak var lblSunset: UILabel!

    @IBOutlet weak var btToday: UIButton!
    @IBOutlet weak var btTomorrow: UIButton!
    @IBOutlet weak var btNext5Days: UIButton!
    @IBOutlet weak var vWeather: UIView!
    @IBOutlet weak var vChangeOfRain: UIView!
    @IBOutlet weak var cvWeatherByHour: UICollectionView!

    let cities = Observable.of(["Lisbon", "Copenhagen", "London", "Madrid",
                                "Vienna", "Vienna", "Vienna", "Vienna"])

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addBackgroundImage()
        viewModel.getInitialData()
        self.bindViewModel()
        // Register cell
        self.cvWeatherByHour.backgroundColor = UIColor.clear
        self.cvWeatherByHour.register(UINib(nibName: "WeatherByHourCell", bundle: nil), forCellWithReuseIdentifier: "WeatherByHourCell")
    }

    func bindViewModel() {
        viewModel.weatherData
            .map {[weak self] in self?.setViewData(weatherData: $0)}
            .subscribe()
            .disposed(by: disposeBag)

        viewModel
            .onShowLoadingHud
            .map {[weak self] in self?.setLoadingHud(visible: $0)}
            .subscribe()
            .disposed(by: disposeBag)

        viewModel.weatherForeCastData.bind(to: cvWeatherByHour.rx.items) { (collectionView: UICollectionView, index: Int, element: WeatherResponse) -> UICollectionViewCell in
            let indexPath = IndexPath(row: index, section: 0)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherByHourCell", for: indexPath) as! WeatherByHourCell
            cell.data = element
            return cell
        }.disposed(by: disposeBag)

        cvWeatherByHour.rx
            .modelSelected(String.self)
            .subscribe(onNext: { model in
                print("\(model) was selected")
            })
            .disposed(by: disposeBag)

        cvWeatherByHour.rx.setDelegate(self).disposed(by: disposeBag)


    }

    private func setLoadingHud(visible: Bool) {
        PKHUD.sharedHUD.contentView = PKHUDSystemActivityIndicatorView()
        visible ? PKHUD.sharedHUD.show(onView: view) : PKHUD.sharedHUD.hide()
    }

    func setViewData(weatherData: WeatherResponse) {
        lblDate.text = weatherData.date?.string(with: "EEE, DD, MMM")
        lblTemperature.text = weatherData.temp
        lblPlace.text = weatherData.place
        ivWeather.sd_setImage(with: URL(string: weatherData.icon), placeholderImage: UIImage(named: "placeholder.png"))
        lblFeelsLike.text = "Feels like \(weatherData.feelsLike)"
        guard let sunset = weatherData.sunset else {
            return
        }
         lblSunset.text = "Sunset \(sunset.string(with: "HH:MM"))"

    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         return CGSize(width: CGFloat((60)), height: CGFloat(120))
       }
}
