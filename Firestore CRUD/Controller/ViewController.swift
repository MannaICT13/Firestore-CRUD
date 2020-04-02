//
//  ViewController.swift
//  Firestore CRUD
//
//  Created by Md Khaled Hasan Manna on 2/4/20.
//  Copyright © 2020 Md Khaled Hasan Manna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
      addNavigationItem()
    }
    
  
    
    
    func addNavigationItem(){
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBtnAction(_ :)))
        
    }

    @objc func addBtnAction(_ sender : UIBarButtonItem){
        let addVC = storyboard?.instantiateViewController(identifier: "AddViewController") as! AddViewController
        self.navigationController?.pushViewController(addVC, animated: true)
        
        
    }

}

