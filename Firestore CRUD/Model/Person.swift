//
//  Person.swift
//  Firestore CRUD
//
//  Created by Md Khaled Hasan Manna on 3/4/20.
//  Copyright © 2020 Md Khaled Hasan Manna. All rights reserved.
//

import Foundation

class Person{
    
    var name : String = ""
    var age :Int = 0
    var city : String = ""
    var id : String = ""
    
    
    init(name:String,age :Int,city: String,id : String) {
        self.name = name
        self.age = age
        self.city = city
        self.id = id
    }
    
    
}
