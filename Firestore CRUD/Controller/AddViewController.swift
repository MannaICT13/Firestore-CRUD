//
//  AddViewController.swift
//  Firestore CRUD
//
//  Created by Md Khaled Hasan Manna on 2/4/20.
//  Copyright © 2020 Md Khaled Hasan Manna. All rights reserved.
//

import UIKit
import Firebase

class AddViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var saveBtnOutlet: UIButton!
  
   // var total = Int()
    
    var db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilites.fillButtonStyle(button: saveBtnOutlet!)
        Utilites.lineTextFieldStyle(textField: nameTextField)
        Utilites.lineTextFieldStyle(textField: ageTextField)
        Utilites.lineTextFieldStyle(textField: cityTextField)
      // saveBtnOutlet.setTitle("\(total)", for: .normal)

       
    }
    
    
    
    @IBAction func saveBtnAction(_ sender: Any) {
        
        guard let name = nameTextField.text else{return}
        guard let age = ageTextField.text else{return}
        guard let city = cityTextField.text else{return}
        
        
        if TextFieldValidation.nameValidation(name: name) == false{
            self.alertDialouge1(title: "Error Message!", msg: "Invalide Name")
        }
        else if TextFieldValidation.ageValidiation(age: age.trimmingCharacters(in: .whitespacesAndNewlines)) == false{
            self.alertDialouge1(title: "Error Message!", msg: "Invalide Age")
            
        }else if TextFieldValidation.cityValidiation(city: city) == false{
            self.alertDialouge1(title: "Error Message", msg: "Invalide City")
        }else{
              writePerson(name: name, age: Int(age)! , city: city)
            
        }
        
      
        
    }
    


}
extension AddViewController{
    
    
    func writePerson(name: String,age: Int,city:String){
        
        db.collection("Person").addDocument(data: [
        
            "name":name,
            "age":age,
            "city":city
        
        ]) { (error) in
            
            if let err = error{
                
              //  print(err.localizedDescription)
                self.alertDialouge1(title: "Error Alert!", msg: err.localizedDescription)
                
                return
            }else{
                //print("Successfully added Person")
               // self.alertDialouge(title: "Success Alert!", msg: "Successfully added Person")
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        
    }
    
    
    
    
}

extension AddViewController{
    
    
    
    func alertDialouge1(title :String, msg:String){
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(ok)
        self.present(alertController, animated: true, completion: nil)
    
    
    
    
    }
    
    
}




