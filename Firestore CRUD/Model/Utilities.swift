//
//  Utilities.swift
//  Firestore CRUD
//
//  Created by Md Khaled Hasan Manna on 3/4/20.
//  Copyright © 2020 Md Khaled Hasan Manna. All rights reserved.
//

import Foundation
import UIKit

class Utilites {
    
    static func fillButtonStyle(button : UIButton){
        
        button.backgroundColor = UIColor(red: 44/255, green: 88/255, blue: 176/255, alpha: 1.0)
        button.layer.cornerRadius = 20.0
        button.layer.borderWidth = 2.0
        button.layer.borderColor = UIColor.black.cgColor
    
        
        
        
    }
    
    static func lineTextFieldStyle(textField: UITextField){
        
          
             let bottomLine = CALayer()
             
             bottomLine.frame = CGRect(x: 0, y: textField.frame.height-2 , width: textField.frame.width, height: 2)
             bottomLine.backgroundColor =  CGColor.init(srgbRed: 44/255, green: 88/255, blue: 172/255, alpha: 1)
             textField.borderStyle = .none
       
             textField.layer.addSublayer(bottomLine)
        
    }
    
    
}
