//
//  ViewController.swift
//  Firestore CRUD
//
//  Created by Md Khaled Hasan Manna on 2/4/20.
//  Copyright © 2020 Md Khaled Hasan Manna. All rights reserved.
//

import UIKit
import Firebase
class ViewController: UIViewController {

    var db = Firestore.firestore()
    var person = [Person]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      addNavigationItem()
        
        readPerson { (person) in
            
            self.person = person
            self.tableView.reloadData()
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        
        
    }
    
  
    
    
    func addNavigationItem(){
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBtnAction(_ :)))
        
    }

    @objc func addBtnAction(_ sender : UIBarButtonItem){
        let addVC = storyboard?.instantiateViewController(identifier: "AddViewController") as! AddViewController
        self.navigationController?.pushViewController(addVC, animated: true)
        
        
    }

}
extension ViewController{
    
    
    func readPerson(completed : @escaping ([Person]) -> Void){
        
        var person = [Person]()
        let dispatch = DispatchGroup()
        dispatch.enter()
        
        db.collection("Person").getDocuments() { (snapshot, error) in
            
            if let err = error{
                
                print(err.localizedDescription)
                return
            }else{
                
                for result in snapshot!.documents{
                    
                    
                    guard let name = result.data()["name"] else{return}
                    guard let age = result.data()["age"] else{return}
                    guard let city = result.data()["city"] else{return}
                
                    person.append(Person(name: name as! String, age: age as! Int, city: city as! String, id: result.documentID))
                    self.tableView.reloadData()
                    
                    
                    
                }
                
               
            }
            dispatch.leave()
            
        }
        dispatch.notify(queue: .main, execute: {
            print("\(person.count)")
            completed(person)
            
        })
        
        
            
        
    }
    
    
    
    
    
    
    
}

extension ViewController : UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        person.count
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
              let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
             // cell.textLabel?.text = person[indexPath.row].name
             cell.textLabel?.text = String(person[indexPath.row].age)
              
              
              return cell
    }
    
    
    
}
