//
//  ViewController.swift
//  weatherAppYAY
//
//  Created by COREY ATKINSON on 1/19/24.
//

import UIKit

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let cod: String
    let message, cnt: Int
    let list: [List]
    let city: City
}

// MARK: - City
struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone, sunrise, sunset: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lat, lon: Double
}

// MARK: - List
struct List: Codable {
    let dt: Int
    let main: MainClass
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
    let pop: Double
    let sys: Sys
    let dtTxt: String
    let snow, rain: Rain?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, sys
        case dtTxt = "dt_txt"
        case snow, rain
    }
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - MainClass
struct MainClass: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - Rain
struct Rain: Codable {
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

// MARK: - Sys
struct Sys: Codable {
    let pod: Pod
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main: MainEnum
    let description, icon: String
}

enum MainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
    case snow = "Snow"
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}

class Day {
    var temp : String
    var day : String
    var windSpeed : String
    var sky : String
    var windDeg : Int
    init(temp: String, day: String, windSpeed: String, sky: String, windDeg: Int) {
        self.temp = temp
        self.day = day
        self.windSpeed = windSpeed
        self.sky = sky
        self.windDeg = windDeg
    }
    
    
}

public class AppData {
    static var days = [Day]()
    static var index = 0
}



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    
    @IBOutlet weak var tableOutlet: UITableView!
    var i = 0
  //  var days = [Day]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableOutlet.delegate = self
        tableOutlet.dataSource = self

        
        print("view loads")
        getWeather()
        
        // getDayOfWeek(today: "")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableOutlet.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppData.days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")!
        cell.textLabel?.text = AppData.days[indexPath.row].day
        cell.textLabel?.textColor = UIColor.systemBackground
        cell.detailTextLabel?.text = "\(AppData.days[indexPath.row].temp)°F"
        cell.detailTextLabel?.textColor = UIColor.systemBackground
        
               return cell

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        AppData.index = Int(indexPath.row)
        print("the row clicked was \(AppData.index)")
        
        
        performSegue(withIdentifier: "mySeg", sender: nil)
        }
    
    
    
    func getDayOfWeek(today:String)->String? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let todayDate = formatter.date(from: today)
        formatter.dateFormat = "EEEE" // "eeee" -> Friday
        let weekDay = formatter.string(from: todayDate!)
        
        return weekDay
    }
    
    
    
    
    
    //my key:   661c93a0580a7abef3c264610b9296e2
    //crystal lake lat and lon lat=44.2411&lon=-88.3162
    
    func getWeather(){
        
        let session = URLSession.shared
        
        //creating URL for api call (you need your apikey)
        let weatherURL = URL(string: "http://api.openweathermap.org/data/2.5/forecast?units=imperial&lat=44.2411&lon=-88.3162&appid=661c93a0580a7abef3c264610b9296e2"
        )!
        
        // Making an api call and creating data in the completion handler
        let dataTask = session.dataTask(with: weatherURL) {
            // completion handler: happens on a different thread, could take time to get data
            (data: Data?, response: URLResponse?, error: Error?) in
            
            if let error = error {
                print("Error:\n\(error)")
            } else {
                // if there is data
                if let data = data {
                    print("found data")
                    // convert data to json Object
                    if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary {
                        // print the jsonObj to see structure
                       // print(jsonObj)
                        
                        
                        if let welc = try? JSONDecoder().decode(Welcome.self, from: data){
                            for a in welc.list {
                                // print("this is dt:     \(a.dt)")
                              //  print("got in for loop")
                                  if a.dtTxt.contains("12:00:00")
                                 {
                                
                                print(self.getDayOfWeek(today: a.dtTxt) ?? "")
                                print("this is dt text:     \(a.dtTxt)")
                                print("this is the temp:     \(a.main.temp)")
                                print("this is what it feels like    \(a.main.feelsLike)")
                                print("this is the high:    \(a.main.tempMax)")
                                     
                                      for b in a.weather{
                                          print("this is the sky    \(b.main)")
                                          AppData.days.append(Day(temp: "\(a.main.temp)", day: self.getDayOfWeek(today: a.dtTxt) ?? "", windSpeed: "\(a.wind.speed)", sky: "\(b.main)",windDeg: a.wind.deg))
                                      }
                                     
                                print("\n")
                                 }
                                
                            }
                            for c in AppData.days
                            {
                                print("--Start--")
                                print(c.day)
                                print(c.temp)
                                print(c.windSpeed)
                                print(c.windDeg)
                                print(c.sky)
                                print("--End--")
                                print("\n")
                            }
                            DispatchQueue.main.async {
                                self.tableOutlet.reloadData()
                                                    }
                          
                        }
                        
                        
                        
                        
                        
                        /*
                         if let mainDictionary = jsonObj.value(forKey: "main") as? NSDictionary {
                         
                         // get the value for the key temp
                         if let listObj = mainDictionary.value(forKey: "list") {
                         if let dt = mainDictionary.value(forKey: "dt")
                         {
                         print(dt)
                         }
                         
                         
                         
                         
                         
                         } else {
                         print("Error: unable to find temperature in dictionary")
                         }
                         } else {
                         print("Error: unable to convert json data")
                         }
                         }
                         else {
                         print("Error: Can't convert data to json object")
                         }
                         }
                         
                         */
                        else {
                            print("Error: did not receive data")
                        }
                        
                    }
                    
                }
               
                
            }
        }
        dataTask.resume()
        

    }}
