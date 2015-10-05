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
    
    
    var weeklyWeather: [DailyWeather] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        retrieveWeatherForecast()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func configureView() {
    
        // Set table view's background view property
        tableView.backgroundView = BackgroundView()
        
        // Set custom height for tabel view row
        tableView.rowHeight = 64
        
        // Change the size and font of nav bar text
        if let navBarFont = UIFont(name: "HelveticaNeue-Thin", size: 20.0) {
            let navBarAttributesDictionary: [String: AnyObject]? = [
                NSForegroundColorAttributeName: UIColor.whiteColor(),
                NSFontAttributeName: navBarFont
            ]
            navigationController?.navigationBar.titleTextAttributes = navBarAttributesDictionary
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        return weeklyWeather.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("WeatherCell") as! DailyWeatherTabelViewCellTableViewCell
        
        let dailyWeather = weeklyWeather[indexPath.row]
        if let maxTemp = dailyWeather.maxTemperature {
            cell.temperatureLabel.text = "\(maxTemp)º"
        }
        cell.weatherIcon.image = dailyWeather.icon
        cell.dayLabel.text = dailyWeather.day
        
        return cell
    }
    
    // MARK: - Weather Fetching
    
    func retrieveWeatherForecast() {
        let forecastService = ForecastService(APIKey: forecastAPIKey)
        forecastService.getForecast(coordinat.lat, long: coordinat.long){
            (let forecast) in
            if let weatherForecast = forecast,
            let currentWeather = weatherForecast.currentWeather {
                dispatch_async(dispatch_get_main_queue()) {
                    
                    if let tempereture = currentWeather.temperature {
                        self.currentTemperatureLabel?.text = "\(tempereture)º"
                    }
                    
                    if let precipitation = currentWeather.precipProbabitily {
                        self.currentPrecipitationLabel?.text = "Rain: \(precipitation)%"
                    }
                    
                    if let icon = currentWeather.icon {
                        self.currentWeatherIcon?.image = icon
                    }
                    
                    self.weeklyWeather = weatherForecast.weekly
                    
                    if let highTemp = self.weeklyWeather.first?.maxTemperature,
                        let lowTemp = self.weeklyWeather.first?.minTemperature {
                            self.currentTemperatureRangeLabel?.text = "↑\(highTemp)º↓\(lowTemp)º"
                    }
                    
                    self.tableView.reloadData()
                }
            }
        }
    }

    
    
}
