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
   // var totalAge = Int()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      addNavigationItem()
        
        readPerson { (person) in
            
            self.person = person
            self.tableView.reloadData()
            
        }
        
      //  tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        
    }
    override func viewWillAppear(_ animated: Bool) {
        readPerson { (person) in
            self.person = person
            self.tableView.reloadData()
        }
    }
 
    
    
    func addNavigationItem(){
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBtnAction(_ :)))
        
    }

    @objc func addBtnAction(_ sender : UIBarButtonItem){
        let addVC = storyboard?.instantiateViewController(identifier: "AddViewController") as! AddViewController
        
      //  addVC.total = totalAge
        
        self.navigationController?.pushViewController(addVC, animated: true)
        
        
    }

}
extension ViewController{
    
    //read from firestore
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
    
    //delete from firestore
    
    func deletePerson(id:String){
        
        db.collection("Person").document(id).delete { (error) in
            
            if let err = error{
                
                print(err.localizedDescription)
            }else{
                print("Successfully delete data")
            }
        }
        
        
        
        
    }
    //update data
    
    func updatePerson(id : String,name : String,age:Int,city : String){
        db.collection("Person").document(id).updateData([
        
            "name":name,
            "age":age,
            "city":city
        
        
        ]) { (error) in
            if let err = error{
                print(err.localizedDescription)
            }else{
                print("Successfully update data")
                
                self.readPerson { (person) in
                    self.person = person
                    self.tableView.reloadData()
                }
            }
        }
        
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
        return 114
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             
              let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
             // cell.textLabel?.text = person[indexPath.row].name
              // cell.textLabel?.text = String(person[indexPath.row].age)
             //  totalAge += Int(person[indexPath.row].age)
        cell.nameLbl.text = person[indexPath.row].name
        cell.ageLbl.text = String(person[indexPath.row].age)
        cell.cityLbl.text = person[indexPath.row].city
        
             
       
              return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete", handler: { (action, view, nil) in
           
            let alertController = UIAlertController(title: "Delete Alert!", message: "You want to delete the row?", preferredStyle: .actionSheet)
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancel)
            let delete = UIAlertAction(title: "Delete", style: .destructive) { (action) in
                  
                          self.deletePerson(id: self.person[indexPath.row].id)
                          self.person.remove(at: indexPath.row)
                          self.tableView.deleteRows(at: [indexPath], with: .automatic)
                          
            }
            alertController.addAction(delete)
            self.present(alertController, animated: true, completion: nil)
            
        })
        
        
        
        let edit = UIContextualAction(style: .normal, title: "Edit") { (action, view, nil) in
            
            let alertController = UIAlertController(title: "Update Alert!", message: "You want to update row?", preferredStyle: .alert)
            
            alertController.addTextField { (nameTxt) in
                nameTxt.placeholder = "Name"
                nameTxt.text = self.person[indexPath.row].name
                
                
            }
            alertController.addTextField { (ageTxt) in
                ageTxt.placeholder = "Age"
                ageTxt.text = String(self.person[indexPath.row].age)
                
            }
            alertController.addTextField { (cityTxt) in
                cityTxt.placeholder = "City"
                cityTxt.text = self.person[indexPath.row].city
            }
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancel)
            
            let update = UIAlertAction(title: "Update", style: .default) { (action) in
                
                guard let name = alertController.textFields![0].text else{return}
                guard let age = alertController.textFields![1].text else{return}
                guard let city = alertController.textFields![2].text else{return}
                
                self.updatePerson(id: self.person[indexPath.row].id, name: name, age: Int(age)!, city: city)
               
                
            }
            alertController.addAction(update)
            self.present(alertController, animated: true, completion: nil)
            
            
            
            
            
        }
        
    
        
        let config = UISwipeActionsConfiguration(actions: [delete,edit])
        config.performsFirstActionWithFullSwipe = false
        return config
        
        
        
    }
    
    
    
    
}
