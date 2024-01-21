//
//  ThirdViewController.swift
//  weatherAppYAY
//
//  Created by COREY ATKINSON on 1/20/24.
//

import UIKit
import Foundation

struct Yay: Codable{
    let weather: [Weathe]
}

struct Weathe: Codable {
    let main: String
}
extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
        // or use capitalized(with: locale) if you want
    }
}

class ThirdViewController: UIViewController {

    
    @IBOutlet weak var dayOutlet: UILabel!
    
    @IBOutlet weak var currentTempOutlet: UILabel!
    
    @IBOutlet weak var lowOutlet: UILabel!
    
    @IBOutlet weak var highOutlet: UILabel!
    
    @IBOutlet weak var degreeOutlet: UIImageView!
    
    @IBOutlet weak var speedOutlet: UILabel!
    
    @IBOutlet weak var skyImageOutlet: UIImageView!
    
    @IBOutlet weak var skyOutlet: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
todaysWeather()
        print(Date().dayOfWeek()!) // Wednesday
        dayOutlet.text = Date().dayOfWeek()!
        // Do any additional setup after loading the view.
    }
    

   
    
    
    
    
    
    func todaysWeather(){
        // creating object of URLSession class to make api call
        let session = URLSession.shared

                //creating URL for api call (you need your apikey)
                let weatherURL = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=44.24114&lon=-88.3162&units=imperial&appid=661c93a0580a7abef3c264610b9296e2")!

                // Making an api call and creating data in the completion handler
                let dataTask = session.dataTask(with: weatherURL) {
                    // completion handler: happens on a different thread, could take time to get data
                    (data: Data?, response: URLResponse?, error: Error?) in

                    if let error = error {
                        print("Error:\n\(error)")
                    } else {
                        // if there is data
                        if let data = data {
                            // convert data to json Object
                            if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary {
                                // print the jsonObj to see structure
                                print(jsonObj)
                                
                                // find main key and get all the values as a dictionary
                                if let mainDictionary = jsonObj.value(forKey: "main") as? NSDictionary {
                                    
                                    // get the value for the key temp
                                    if let temperature = mainDictionary.value(forKey: "temp") {
                                        
                                        var t = temperature as! Double
                                       
                                        let doubleStr = String(format: "%.2f", t)

                                        // make it happen on the main thread so it happens during viewDidLoad
                                        DispatchQueue.main.async {
                                            // making the value show up on a label
                                            self.currentTempOutlet.text = "current temerature: \(doubleStr)°F"
                                        }
                                        if let max = mainDictionary.value(forKey: "temp_max") {
                                            var m = max as! Double
                                            let doubleStr = String(format: "%.2f", m)
                                            
                                            // make it happen on the main thread so it happens during viewDidLoad
                                            DispatchQueue.main.async {
                                                // making the value show up on a label
                                                self.highOutlet.text = "Today's High: \(doubleStr)°F"
                                            }
                                            
                                        }
                                        
                                        if let min = mainDictionary.value(forKey: "temp_min") {
                                            
                                            var m = min as! Double
                                            let doubleStr = String(format: "%.2f", m)
                                            
                                            // make it happen on the main thread so it happens during viewDidLoad
                                            DispatchQueue.main.async {
                                                // making the value show up on a label
                                                self.lowOutlet.text = "Today's Low: \(doubleStr)°F"
                                            }
                                            
                                        }
                                        
                                        
                                        
                                    }
                                    if let win = jsonObj.value(forKey: "wind") as? NSDictionary {
                                        if let degree = win.value(forKey: "deg") {
                                            
                                            let d = degree as! Int
                                            
                                            print()
                                            
                                            // make it happen on the main thread so it happens during viewDidLoad
                                            DispatchQueue.main.async {
                                                
                                                if((d >= 340 && d <= 360 )||(d >= 0 && d <= 20 ) )
                                                {
                                                    self.degreeOutlet.image = UIImage(named: "northA")
                                                }
                                                if(d > 20 && d < 70 )
                                                {
                                                    self.degreeOutlet.image = UIImage(named: "ne")
                                                }
                                                if(d >= 70 && d <= 110 )
                                                {
                                                    self.degreeOutlet.image = UIImage(named: "eastA")
                                                }
                                                if(d > 110 && d < 160 )
                                                {
                                                    self.degreeOutlet.image = UIImage(named: "se")
                                                }
                                                if(d >= 160 && d <= 200 )
                                                {
                                                    self.degreeOutlet.image = UIImage(named: "southA")
                                                }
                                                if(d > 200 && d < 250 )
                                                {
                                                    self.degreeOutlet.image = UIImage(named: "sw")
                                                }
                                                if(d >= 250 && d <= 290 )
                                                {
                                                    self.degreeOutlet.image = UIImage(named: "westA")
                                                }
                                                if(d > 290 && d < 340 )
                                                {
                                                    self.degreeOutlet.image = UIImage(named: "sw")
                                                }
                                               
                                                
                                                
                                                
                                                
                                                
                                            }
                                            
                                        }
                                        if let spee = win.value(forKey: "speed") {
                                            
                                            var s = spee as! Double
                                           
                                            let doubleStr = String(format: "%.2f", s)
                                            
                                            DispatchQueue.main.async {
                                                self.speedOutlet.text = "\(doubleStr) mph"
                                                
                                                
                                                
                                            }
                                            
                                            
                                            
                                        }
                                        if let yay = try? JSONDecoder().decode(Yay.self, from: data){
                                            for a in yay.weather{
                                                print("the main of weather is this;          \(a.main)")
                                                
                                            }
                                            
                                            DispatchQueue.main.async {
                                                self.skyOutlet.text = "\(yay.weather[0].main)"
                                                if(yay.weather[0].main == "Clear")
                                                {
                                                    self.skyImageOutlet.image = UIImage(named: "clear")
                                                }
                                                if(yay.weather[0].main == "Clouds")
                                                {
                                                    self.skyImageOutlet.image = UIImage(named: "clouds")
                                                }
                                                if(yay.weather[0].main == "Rain")
                                                {
                                                    self.skyImageOutlet.image = UIImage(named: "rain")
                                                }
                                                if(yay.weather[0].main == "Snow")
                                                {
                                                    self.skyImageOutlet.image = UIImage(named: "snow")
                                                }

                                
                                            }
                                            
                                            
                                        }
                                    }
                                    
                                    
                                    
                                    
                                    else {
                                        print("Error: unable to find temperature in dictionary")
                                    }
                                } else {
                                    print("Error: unable to convert json data")
                                }
                            }
                            else {
                                print("Error: Can't convert data to json object")
                            }
                        }else {
                            print("Error: did not receive data")
                        }
                    }
                }

                dataTask.resume()


                
        
        
    }

   

}
