//
//  ViewController.swift
//  Todoey
//
//  Created by Youdo Leam on 12/7/18.
//  Copyright © 2018 Youdo Leam. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
var itemArray = [Item]()
let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // .userDomainMask is user home directory
       
       // print(dataFilePath)
//        let newItem = Item()
//        newItem.title = "Go shooping"
//        itemArray.append(newItem)
//
//        let newItem1 = Item()
//        newItem1.title = "Go clue"
//        itemArray.append(newItem1)
//
//        let newItem2 = Item()
//        newItem2.title = "Reading"
//        itemArray.append(newItem2)
////        if let items = defaults.array(forKey: "ToDoListArray") as? [Item]{
////            itemArray = items
////        }
        loadItem()
        }
       

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        cell.accessoryType = itemArray[indexPath.row].done == true ? .checkmark : .none
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItem()
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
//        {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }
//        else
//        {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
//
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem)
    {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) {
            (action) in
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            self.saveItem()
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
           
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveItem ()
    {
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(self.itemArray)
            try data.write(to: self.dataFilePath!)
        }catch{
            print("Encoding error")
        }
    }
    func loadItem ()
    {
        let decoder = PropertyListDecoder()
    
           if let data =  try? Data(contentsOf: dataFilePath!) {
                let decoder = PropertyListDecoder()
                do
                {
                       itemArray = try decoder.decode([Item].self, from: data)
                }catch{
                    print("Decoding Error")
                }
            }
        
        
    }
}

