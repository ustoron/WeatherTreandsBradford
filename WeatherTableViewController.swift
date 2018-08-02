//
//  WeatherTableViewController.swift
//  testTaskWeather
//
//  Created by Ulyana Storonyanska on 18.07.18.
//  Copyright © 2018 Ulyana Storonyanska. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController, UISearchBarDelegate {

    var forecastData = [Weather]()
    var forecastDataFiltered = [Weather]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Weather.forecast(completion: { (results: [Weather]?)in
            if let weatherData = results {
                self.forecastData = weatherData
            }
        })
        searchBar.delegate = self
        
    }
    
    

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let yearSer = searchBar.text, !yearSer.isEmpty {
            updateWeatherDataForYear(yearS: yearSer)
            
        }
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }

    }
    
    func updateWeatherDataForYear (yearS : String){

        self.forecastDataFiltered = forecastData.filter( {($0.summary?.contains(yearS))!} )
        if self.forecastDataFiltered.isEmpty {
            self.forecastDataFiltered.append(Weather.init(weatherOneMonth: "Enter year from 1908 tо 2018"))
        }
        print(self.forecastDataFiltered)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(forecastData.count)
        return self.forecastDataFiltered.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let weatherObject = self.forecastDataFiltered[indexPath.row]
        cell.textLabel?.text = weatherObject.summary
       
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " yyyy  mm  tmax  tmin  af(days) rain(mm) sun(hours)"
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        
        let headerLabel = UILabel(frame: CGRect(x: 30, y: 0, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont(name: "Verdana", size: 12)
        headerLabel.textColor = UIColor.darkText
        headerLabel.text = self.tableView(self.tableView, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    

}
