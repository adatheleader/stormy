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
    let coordinat: (lat: Double, long: Double) = (52.7574,41.4325)
    let APIoptions = "?units=si"
    
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
        
        // Position refresh control above background view
        refreshControl?.layer.zPosition = (tableView.backgroundView?.layer.zPosition)! + 1
        
        refreshControl?.tintColor = UIColor.whiteColor()
    }
    
    @IBAction func refreshWeather() {
        
        retrieveWeatherForecast()
        refreshControl?.endRefreshing()
    }
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDaily" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let dailyWeather = weeklyWeather[indexPath.row]
                (segue.destinationViewController as! ViewController).dailyWeather = dailyWeather
            }
        }
    }

    
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Forecast"
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
    
    // MARK: - Delagate Methods
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor(red: 170/255.0, green: 131/255.0, blue: 224/255.0, alpha: 1.0)
        
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 14.0)
            header.textLabel?.textColor = UIColor.whiteColor()
        }
    }
    
    override func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.contentView.backgroundColor = UIColor(red: 165/255.0, green: 142/255.0, blue: 203/255.0, alpha: 1.0)
        let highlightView = UIView()
        highlightView.backgroundColor = UIColor(red: 165/255.0, green: 142/255.0, blue: 203/255.0, alpha: 1.0)
        cell?.selectedBackgroundView = highlightView
    }
    
    // MARK: - Weather Fetching
    
    func retrieveWeatherForecast() {
        let forecastService = ForecastService(APIKey: forecastAPIKey)
        forecastService.getForecast(coordinat.lat, long: coordinat.long, APIoptions: APIoptions){
            (let forecast) in
            if let weatherForecast = forecast,
            let currentWeather = weatherForecast.currentWeather {
                dispatch_async(dispatch_get_main_queue()) {
                    
                    if let temperature = currentWeather.temperature {
                        self.currentTemperatureLabel?.text = "\(temperature)º"
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
