//
//  ViewController.swift
//  AndrysekWeatherApp
//
//  Created by Ondrej Andrysek on 17/02/2016.
//  Copyright © 2016 Ondrej Andrysek. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    //references to outlets
    @IBOutlet weak var TextLabelCity: UILabel!
    @IBOutlet weak var TextLabelTemp: UILabel!
    @IBOutlet weak var TextLabelMoreDesc: UILabel!
    @IBOutlet weak var TextFieldGetWeather: UITextField!
    @IBOutlet weak var ImageIcon: UIImageView!
    
    private var weatherInfo: WeatherStruct?
    
    override func viewDidLoad() {
        getInfo("Brno")
        super.viewDidLoad()
        InitializeKeyboard()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    

}

extension ViewController{
    //function to get information from server and then display it
    func getInfo(city : String){
        
        RestApiManager.sharedInstance.setCity(city)
        RestApiManager.sharedInstance.getDataFromURL { (json) -> Void
            in
            
            //set weather struct
            self.weatherInfo = WeatherStruct(json: json)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.setInfo(self.weatherInfo!)
            })
            
        }
    }
    
    //function to get error with explanation as parameter
    func getError(reasonOfError: String){
        let alertController = UIAlertController(title: "Error", message: reasonOfError, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    //function to dismiss keyboard after tapping anywhere
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    
    func setInfo(weather: WeatherStruct){
        self.TextLabelCity.text = weather.name
        self.TextLabelCity.adjustsFontSizeToFitWidth = true
        self.TextLabelTemp.text = "\(weather.temp) °C"
        self.TextLabelMoreDesc.text = weather.desc
        self.ImageIcon.image = UIImage(named: weather.icon)
    }
    
    func InitializeKeyboard(){
        TextFieldGetWeather.delegate = self
        TextFieldGetWeather.keyboardType = UIKeyboardType.Alphabet
    }
    
    //function to prevent user to type invalid characters
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange,
        replacementString string: String)
        -> Bool
    {
        
        if string.characters.count == 0 {
            return true
        }
        
        
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).stringByReplacingCharactersInRange(range, withString: string)
        
        return prospectiveText.containsOnlyCharactersIn("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ -.") &&
            prospectiveText.characters.count <= 19
        
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    
    //update outlets if Get Weather button is tapped
    @IBAction func GetWeatherTapped(sender: AnyObject) {
        
        //test if textfield is not empty
        if(TextFieldGetWeather.text != ""){
            
            //replace space in text field
            let fixedTextFieldGetWeather = TextFieldGetWeather.text?.stringByReplacingOccurrencesOfString(" ", withString: "_")
            
            getInfo(fixedTextFieldGetWeather!)
            
            //reset textfield
            TextFieldGetWeather.text = ""
            
            super.viewWillAppear(true)
        }
        else {
            self.getError("Type in city")
            
        }
        
    }
}

extension Double{
    func roundTo(places: Int) -> Double{
        let divisor = pow(10.0, Double(places))
        return round((self * divisor)) / divisor
    }
}