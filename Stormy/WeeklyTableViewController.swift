//
//  WeeklyTableViewController.swift
//  Stormy
//
//  Created by Лидия Хашина on 21.09.15.
//  Copyright © 2015 OnlineLab. All rights reserved.
//

import UIKit

class WeeklyTableViewController: UITableViewController {

    @IBOutlet weak var currentTemperatureLabel: UILabel?
    @IBOutlet weak var currentWeatherIcon: UIImageView?
    @IBOutlet weak var currentPrecipitationLabel: UILabel?
    @IBOutlet weak var currentTemperatureRangeLabel: UILabel?
    
    private let forecastAPIKey = "176cd129c5d339df83810066b26b5d7d"
    let coordinat: (lat: Double, long: Double) = (37.8267,-122.423)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundView = BackgroundView()
        
        retrieveWeatherForecast()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    // MARK: - Weather Fetching
    
    func retrieveWeatherForecast() {
        let forecastService = ForecastService(APIKey: forecastAPIKey)
        forecastService.getForecast(coordinat.lat, long: coordinat.long){
            (let currently) in
            if let currentWeather = currently {
                dispatch_async(dispatch_get_main_queue()) {
                    
                    if let tempereture = currentWeather.temperature {
                        self.currentTemperatureLabel?.text = "\(tempereture)º"
                    }
                    
                    if let precipitation = currentWeather.precipProbabitily {
                        self.currentPrecipitationLabel?.text = "\(precipitation)%"
                    }
                    
                    if let icon = currentWeather.icon {
                        self.currentWeatherIcon?.image = icon
                    }
                    
                }
            }
        }
    }

    
    
}
