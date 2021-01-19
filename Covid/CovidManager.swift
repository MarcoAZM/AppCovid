//
//  CovidManager.swift
//  Covid
//
//  Created by Mac14 on 16/12/20.
//  Copyright © 2020 Zavala. All rights reserved.
//

import Foundation

protocol CovidManagerDelegate {
    func updateCovid(Covid: CovidModel)
}

struct CovidManager {
    var delegate: CovidManagerDelegate?
    
    let url="https://corona.lmao.ninja/v3/covid-19/countries/"
    
    func fetchCovid(country: String){
        let urlString = "\(url)\(country)"
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let tarea = session.dataTask(with: url) { (data, respuesta, error) in
                if error != nil {
                    print("Error1")
                    return
                }
                if let datosSeguros = data {
                    if let covid = self.parseJSON(covidData: datosSeguros){
                        self.delegate?.updateCovid(Covid: covid)
                    }
                }
            }
            tarea.resume()
        }
    }
    
    func parseJSON(covidData: Data) -> CovidModel? {
        let decoder = JSONDecoder()
        do{
            let dataDecodificada = try decoder.decode(CovidData.self, from: covidData)
            print(dataDecodificada)
            let country = dataDecodificada.country
            let updated = dataDecodificada.updated
            let flag = dataDecodificada.countryInfo.flag
            let cases = dataDecodificada.cases
            let todayCases = dataDecodificada.todayCases
            let deaths = dataDecodificada.deaths
            let todayDeaths = dataDecodificada.todayDeaths
            let active = dataDecodificada.active
            let recovered = dataDecodificada.recovered
            let todayRecovered = dataDecodificada.todayRecovered
            let population = dataDecodificada.population
            let continent = dataDecodificada.continent
            let casesPerMillion = dataDecodificada.casesPerOneMillion
            let ObjCovid = CovidModel(country: country, updated: updated, flag: flag, cases: cases, todayCases: todayCases, deaths: deaths, todayDeaths: todayDeaths,recovered: recovered, todayRecovered: todayRecovered, active: active, population: population, continent: continent, casesPerMillion: casesPerMillion)
            return ObjCovid
        } catch{
            print("Error2")
            return nil
        }
    }
    
}
