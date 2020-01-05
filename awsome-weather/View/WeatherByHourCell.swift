//
//  WeatherByHourCell.swift
//  awsome-weather
//
//  Created by ThienMD on 1/4/20.
//  Copyright © 2020 ThienMD. All rights reserved.
//

import UIKit
import SDWebImage

class WeatherByHourCell: UICollectionViewCell {
    var data: WeatherResponse? {
        didSet {
            self.updateView()
        }
    }
    @IBOutlet weak var vContent: UIView!
    @IBOutlet weak var lblCelcius: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var ivWeather: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        vContent.backgroundColor = .clear
        vContent.layer.borderColor = UIColor.white.cgColor
        vContent.layer.borderWidth = 1
        vContent.layer.cornerRadius = 30
        ivWeather.image = ivWeather.image?.imageWithColor(color: .white)
    }

    func updateView() {
        guard let data = self.data else {
            return
        }
        lblCelcius.text = "\(data.temp) °C"
        lblTime.text = data.date?.string(with: "hh:a")
        ivWeather.sd_setImage(with: URL(string: data.icon), placeholderImage: UIImage(named: "007-eclipse.png"))
    }
}
