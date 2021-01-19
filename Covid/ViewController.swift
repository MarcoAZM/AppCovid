//
//  ViewController.swift
//  Covid
//
//  Created by Mac14 on 16/12/20.
//  Copyright © 2020 Zavala. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var covidManager = CovidManager()
    
    @IBOutlet weak var regionImage: UIImageView!
    @IBOutlet weak var flagImage: UIImageView!
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var continentLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var activeCasesLabel: UILabel!
    
    @IBOutlet weak var totalCases: UILabel!
    @IBOutlet weak var totalDeaths: UILabel!
    @IBOutlet weak var totalRecovered: UILabel!
    
    @IBOutlet weak var todayCases: UILabel!
    @IBOutlet weak var todayDeaths: UILabel!
    @IBOutlet weak var todayRecovered: UILabel!
    
    @IBOutlet weak var casesPerMillion: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        covidManager.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

extension ViewController: CovidManagerDelegate {
    
    @IBAction func searchButton(_ sender: UIButton) {
        covidManager.fetchCovid(country: countryTextField.text!)
    }
    
    func updateCovid(Covid: CovidModel) {
        print(Covid)
        DispatchQueue.main.async {
            let urlString = Covid.flag
            if let url = URL(string: urlString){
                let session = URLSession(configuration: .default)
                let tarea = session.dataTask(with: url) { (data, respuesta, error) in
                      if let error = error {
                         print(error)
                      }
                      guard let data = data else { return }
                      let image = UIImage(data: data)
                      self.flagImage.image = image
                }
                tarea.resume()
            }
            switch Covid.continent {
            case "North America":
                self.regionImage.image = #imageLiteral(resourceName: "North America")
                break
            case "South America":
                self.regionImage.image = #imageLiteral(resourceName: "South America")
                break
            case "Europe":
                self.regionImage.image = #imageLiteral(resourceName: "Europe")
                break
            case "Africa":
                self.regionImage.image = #imageLiteral(resourceName: "Africa")
                break
            case "Asia":
                self.regionImage.image = #imageLiteral(resourceName: "North America")
                break
            case "Australia/Oceania":
                self.regionImage.image = #imageLiteral(resourceName: "Asia")
                break
            default:
                break
            }
            self.countryLabel.text = "País: \(Covid.country)"
            self.continentLabel.text = "Región: \(Covid.continent)"
            self.populationLabel.text = "Población: \(Covid.population)"
            self.activeCasesLabel.text = "\(Covid.active)"
            self.totalCases.text = "Casos: \(Covid.cases)"
            self.totalDeaths.text = "Muertes: \(Covid.deaths)"
            self.totalRecovered.text = "Recuperados: \(Covid.recovered)"
            self.todayCases.text = "Casos: \(Covid.todayCases)"
            self.todayDeaths.text = "Muertes: \(Covid.todayDeaths)"
            self.todayRecovered.text = "Recuperados: \(Covid.todayRecovered)"
            self.casesPerMillion.text = "Casos por millon de personas: \(Covid.casesPerMillion)"
            if Covid.casesPerMillion < 10000 {
                self.statusLabel.text = "País lavemente afectado"
                self.statusLabel.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            }
            else if Covid.casesPerMillion < 50000 {
                self.statusLabel.text = "País medianamente afectado"
                self.statusLabel.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            }
            else {
                self.statusLabel.text = "País altamente afectado"
                self.statusLabel.textColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
            }
        }
    }
}
