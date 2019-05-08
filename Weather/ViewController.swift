//
//  ViewController.swift
//  Weather
//
//  Created by Wilmer sinchi on 12/26/18.
//  Copyright © 2018 Wilmer sinchi. All rights reserved.
//

import UIKit


class ViewController2: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var cityTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    }
    
    
    
    @IBAction func getWeahter(_ sender: AnyObject) {
        // force unwrapt this string becuase you created the string itself
        //notice that it is https not HTTP, soo we had to do something in the iplist
        //control click, source file ,
        
        let url2 = URL(string:"https://www.weather-forecast.com/locations/"+cityTextField.text!+"/forecasts/latest")!
        let request = NSMutableURLRequest(url: url2)
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            var message = ""
            
            if error != nil {
                print(error)
            } else {
                if let unwrappeedData = data{
                    let dataString = NSString(data: unwrappeedData, encoding: String.Encoding.utf8.rawValue)
                    //                    print(dataString)
                    //string seperator is the put  into array where you see all the text of befreo and after London weather today ,
                    //remember to seperate the double qoute so you dont get an error, so you put \ behind the double qoute
                    var stringsSeperator = "London Weather Today </h2>(1&ndash;3 days)</span><p class=\"b-forecast__table-description-content\"><span class=\"phrase\">"
                    if let contentArray = dataString?.components(separatedBy:stringsSeperator){
                        //should give the same content as before but it will be seperate part of an array by this text ^^ the strings in the strings Seperator
                        // so it should give us the description of the weather of or text the we really want
                        // now we should get rid the text after the one that we dont wan't. so look at the page source in chrome and see where you dont need it
                        if contentArray.count > 0 {
                            //to get rid the text after <span> becuase we just want the test between the string seprateor adn the span
                            stringsSeperator = "</span>"
                            //content array 1 is the piec of info that we want , which is the description of the weather, spp the newcontentarray is bringin the text after the string sperator and will stop after new string separtoe which is </span
                            let newContentArray = contentArray[1].components(separatedBy: stringsSeperator)
                            
                            if newContentArray.count > 0 {
                                //                                 if newContentArray.count > 1 {
                                //                                message = newContentArray[0].replacingOccurrences(of: "&deg;", with: "°")
                                //to get the degree symbol youh would have to hold option shift 8 together
                                //we are replacing the degress symbols of &deg; to actuall degreess symbosl
                                message = newContentArray[0].replacingOccurrences(of: "&deg;", with: "°")
                                
                                //                                print(newContentArray[0])//
                                
                                
                                print(message)
                                
                            }
                            
                            
                        }
                        
                        //                        print(contentArray)
                    }
                    
                }
                
            }
            
            
            //here we put after the if stetement is done soo
            if message == ""{
                message = "the weather couldnt be found, please try again"
            }
            // to display the message of MESSAGE as saoon as it ready from newxontent array
            DispatchQueue.main.sync(execute: {
                // you put self, to identify which view controller you want
                self.resultLabel.text = message
                
            } )
            
        }
        //the url wont work if you dont add this code!!!
        task.resume()
    }
    
//add top constarint and center horizantelly, sett the width 1000 in pizel or the widht to 667
 
}

