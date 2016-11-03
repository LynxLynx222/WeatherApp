//
//  WeatherStruct.swift
//  AndrysekWeatherApp
//
//  Created by Ondrej Andrysek on 27/02/2016.
//  Copyright © 2016 Ondrej Andrysek. All rights reserved.
//

import Foundation

class WeatherStruct {
    let name: String
    let temp: Double
    let desc: String
    let icon: String
    
    required init(json: JSON){
        name = json["name"].stringValue
        temp = json["main"] ["temp"].doubleValue.roundTo(1)
        desc = json["weather"] [0] ["main"].stringValue
        icon = json["weather"] [0] ["icon"].stringValue
    }
}