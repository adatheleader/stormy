//
//  DailyWeatherTabelViewCellTableViewCell.swift
//  Stormy
//
//  Created by Лидия Хашина on 05.10.15.
//  Copyright © 2015 OnlineLab. All rights reserved.
//

import UIKit

class DailyWeatherTabelViewCellTableViewCell: UITableViewCell {

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
