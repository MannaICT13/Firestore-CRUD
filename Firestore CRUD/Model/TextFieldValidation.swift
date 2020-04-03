//
//  TextFieldValidation.swift
//  
//
//  Created by Md Khaled Hasan Manna on 3/4/20.
//

import Foundation

class TextFieldValidation{
    
    static func nameValidation(name:String) -> Bool{
        
     //   let regEx = "^\\w{3,30}$"
       // let nameTrim = name.trimmingCharacters(in: .whitespaces)
        let regEx = "^(([^ ]?)(^[a-zA-Z].*[a-zA-Z]$)([^ ]?))$"
        let validateName = NSPredicate(format: "SELF MATCHES %@", regEx)
        let isValidateName = validateName.evaluate(with: name)
        return isValidateName
        
        
    }
    static func cityValidiation(city: String) -> Bool{
        
        
       // let regEx = "^\\w{3,15}$"
     //   let cityTrim = city.trimmingCharacters(in: .whitespaces)
        let regEx = "^(([^ ]?)(^[a-zA-Z].*[a-zA-Z]$)([^ ]?))$"
        let validateCity = NSPredicate(format: "SELF MATCHES %@", regEx)
        let isValidateCity = validateCity.evaluate(with: city)
        return isValidateCity
           
    }
    
    
    static func ageValidiation(age:String) -> Bool{
        
        let regEx = "^[1-9]\\d{0,2}$"
        let ageTrim = age.trimmingCharacters(in: .whitespacesAndNewlines)
        let validateAge = NSPredicate(format: "SELF MATCHES %@", regEx)
        let isValidateAge = validateAge.evaluate(with: ageTrim)
        return isValidateAge
    }
    
    
    
    
}
 
