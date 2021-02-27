//
//  Meteo.swift
//  Weather_app
//
//  Created by Macbook on 8/30/20.
//  Copyright © 2020 MacOthmane. All rights reserved.
//

import Foundation
struct Meteo :Decodable {
    var weather : [Weather]
    var main : Main
    var name : String
    init() {
        weather = [Weather()]
        main = Main()
        name = ""
    }
}


struct Main :Decodable {
    var temp : Double
    var feels_like : Double
    var temp_min : Double
    var temp_max : Double
    var pressure : Double
    var humidity : Double
    init() {
        temp_min = 0
        temp_max = 0
        feels_like = 0
        temp = 0
        pressure = 0
        humidity = 0
    }
}
//"weather": [
//  {
//    "id": 800,
//    "main": "Clear",
//    "description": "clear sky",
//    "icon": "01d"
//  }
//]
struct Weather : Decodable {
    var id : Int
    var main : String
    var description : String
    var icon : String
    init() {
        id = 1
        main = ""
        description = ""
        icon = ""
    }
}
