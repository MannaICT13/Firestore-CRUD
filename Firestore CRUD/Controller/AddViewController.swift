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
      //  saveBtnOutlet.setTitle("\(total)", for: .normal)

       
    }
    
    
    @IBAction func saveBtnAction(_ sender: Any) {
        
        guard let name = nameTextField.text else{return}
        guard let age = ageTextField.text else{return}
        guard let city = cityTextField.text else{return}
        
        writePerson(name: name, age: Int(age)! , city: city)
        
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
                
                print(err.localizedDescription)
                return
            }else{
                print("Successfully added Person")
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        
    }
    
    
    
    
}
