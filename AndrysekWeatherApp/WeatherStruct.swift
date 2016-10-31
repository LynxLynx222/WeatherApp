//
//  WeatherStruct.swift
//  AndrysekWeatherApp
//
//  Created by Ondrej Andrysek on 27/02/2016.
//  Copyright © 2016 Ondrej Andrysek. All rights reserved.
//

import Foundation

struct WeatherStruct {
    let m_name: String
    let m_temp: Double
    let m_desc: String
    let m_icon: String
    
    init(name: String, temp: Double, desc: String, icon: String){
        m_name = name
        m_temp = temp
        m_desc = desc
        m_icon = icon
    }
}