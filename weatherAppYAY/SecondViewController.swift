//
//  SecondViewController.swift
//  weatherAppYAY
//
//  Created by COREY ATKINSON on 1/20/24.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var dateOutlet: UILabel!
    @IBOutlet weak var compassOutlet: UIImageView!
    
    @IBOutlet weak var tempOutlet: UILabel!
    
    @IBOutlet weak var windDegOutlet: UIImageView!
    
    @IBOutlet weak var windSpeedOutlet: UILabel!
    
    @IBOutlet weak var skyImageOutlet: UIImageView!
    
    @IBOutlet weak var skyOutlet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.bringSubviewToFront(compassOutlet)
        
        
        
        //windDegOutlet.bringSubviewToFront(compassOutlet)
print("made it to next view controller")
        // Do any additional setup after loading the view.
        
        dateOutlet.text = AppData.days[AppData.index].day
        tempOutlet.text = "At noon the tempature will be \(AppData.days[AppData.index].temp)°F"
        windSpeedOutlet.text = "\(AppData.days[AppData.index].windSpeed) mph"
        skyOutlet.text = AppData.days[AppData.index].sky
        
        
        print("the degree is \(AppData.days[AppData.index].windDeg)")
        
        if((AppData.days[AppData.index].windDeg >= 340 && AppData.days[AppData.index].windDeg <= 360 )||(AppData.days[AppData.index].windDeg >= 0 && AppData.days[AppData.index].windDeg <= 20 ) )
        {
            compassOutlet.image = UIImage(named: "northA")
        }
        if(AppData.days[AppData.index].windDeg > 20 && AppData.days[AppData.index].windDeg < 70 )
        {
            compassOutlet.image = UIImage(named: "ne")
        }
        if(AppData.days[AppData.index].windDeg >= 70 && AppData.days[AppData.index].windDeg <= 110 )
        {
            compassOutlet.image = UIImage(named: "eastA")
        }
        if(AppData.days[AppData.index].windDeg > 110 && AppData.days[AppData.index].windDeg < 160 )
        {
            compassOutlet.image = UIImage(named: "se")
        }
        if(AppData.days[AppData.index].windDeg >= 160 && AppData.days[AppData.index].windDeg <= 200 )
        {
            compassOutlet.image = UIImage(named: "southA")
        }
        if(AppData.days[AppData.index].windDeg > 200 && AppData.days[AppData.index].windDeg < 250 )
        {
            compassOutlet.image = UIImage(named: "sw")
        }
        if(AppData.days[AppData.index].windDeg >= 250 && AppData.days[AppData.index].windDeg <= 290 )
        {
            compassOutlet.image = UIImage(named: "westA")
        }
        if(AppData.days[AppData.index].windDeg > 290 && AppData.days[AppData.index].windDeg < 340 )
        {
            compassOutlet.image = UIImage(named: "sw")
        }
       
        
        
        
        if(AppData.days[AppData.index].sky == "clear")
        {
            skyImageOutlet.image = UIImage(named: "clear")
        }
        if(AppData.days[AppData.index].sky == "clouds")
        {
            skyImageOutlet.image = UIImage(named: "clouds")
        }
        if(AppData.days[AppData.index].sky == "rain")
        {
            skyImageOutlet.image = UIImage(named: "rain")
        }
        if(AppData.days[AppData.index].sky == "snow")
        {
            skyImageOutlet.image = UIImage(named: "snow")
        }


        
        
        
        
        
        
        
        
        
    }
    

   

}
