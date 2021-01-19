//
//  CovidData.swift
//  Covid
//
//  Created by Mac14 on 16/12/20.
//  Copyright © 2020 Zavala. All rights reserved.
//

import Foundation

struct CovidData: Codable{
    let country: String
    let updated: Int
    let countryInfo: countryInfo
    let cases: Int
    let todayCases: Int
    let deaths: Int
    let todayDeaths: Int
    let recovered: Int
    let todayRecovered: Int
    let active: Int
    let population: Int
    let continent: String
    let casesPerOneMillion: Int
}

struct countryInfo: Codable{
    let flag: String
}
