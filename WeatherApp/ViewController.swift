
//
//  ViewController.swift
//  WeatherApp
//
//  Created by Ali Can Kayaaslan on 14.03.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    @IBOutlet weak var latitudeTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    
    let api = "e38c1a04c428519320248e9cf5abb796"
    
    var latitudeData: String {
        return latitudeTextField.text ?? ""
    }
    
    var longitudeData: String {
        return longitudeTextField.text ?? ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Weather App"
    }

    @IBAction func getButtonClicked(_ sender: Any) {
        
        // 1- Request to Web site
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitudeData)&lon=\(longitudeData)&appid=\(api)")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            
            // Check data
            if error != nil {
                print("Error")
            } else {
                if data != nil {
            // If data come
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any]
                        
                        DispatchQueue.main.async {
                            if let main = jsonResponse!["main"] as? [String:Any] {
                                if let temp = main["temp"] as? Double {
                                    self.currentTempLabel.text = String(Int(temp - 272.15)) + " °C"
                                }
                            }
                            
                            if let wind = jsonResponse!["wind"] as? [String:Any] {
                                if let speed = wind["speed"] as? Double {
                                    self.windSpeedLabel.text = String(speed)
                                }
                            }
                            
                            if let main = jsonResponse!["main"] as? [String:Any] {
                                if let feels_like = main["feels_like"] as? Double {
                                    self.feelsLikeLabel.text = String(Int(feels_like - 272.15)) + " °C"
                                }
                            }
                        }
                        
                    } catch {
                        
                    }
                    
                }
            }
        }
        task.resume()
    }
    
}
