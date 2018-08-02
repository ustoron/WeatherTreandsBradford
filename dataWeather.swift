//
//  dataWeather.swift
//  testTaskWeather
//
//  Created by Ulyana Storonyanska on 19.07.18.
//  Copyright © 2018 Ulyana Storonyanska. All rights reserved.
//

import Foundation

struct Weather {

    let summary : String?
    init (weatherOneMonth : String){

        self.summary = weatherOneMonth
    }
    
    static let url = URL(string: "https://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/bradforddata.txt")
    
    static func forecast (completion: @escaping ([Weather]?) -> ()){
        
        let task = URLSession.shared.downloadTask(with: url!) { localURL, urlResponse, error in
            var weatherData : [Weather] = []
            
            if let localURL = localURL {
                if let string = try? String(contentsOf: localURL) {
                   
                    
                    let lines : [String] = string.components(separatedBy: "\n")
                    let linesN = lines[7...]
                    for line in linesN {
                       
                        let helpWeather = Weather(weatherOneMonth: line)
                        weatherData.append(helpWeather)
                    }
                }
                completion(weatherData)
            }
            
        }
        task.resume()
        
    }
    
    
    
}
