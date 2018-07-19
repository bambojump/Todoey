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
let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        let item1 = Item()
        item1.title = "Find Mike"
        itemArray.append(item1)
        
        let item2 = Item()
        item2.title = "Buy Eggo"
        itemArray.append(item2)
        
        let item3 = Item()
        item3.title = "Go shopping"
        itemArray.append(item3)
        
        let item4 = Item()
        item4.title = "Dancing"
        itemArray.append(item4)
        
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

    //    Ternary operator
        cell.accessoryType = itemArray[indexPath.row].done ? .checkmark : .none
//        if itemArray[indexPath.row].done == true
//        {
//             cell.accessoryType = .checkmark
//        }
//        else
//        {
//            cell.accessoryType = .none
//        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        //print(itemArray[indexPath.row])
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem)
    {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) {
            (action) in
          
          let item = Item(context: self.context)
           item.title = textField.text!
           self.itemArray.append(item)
           self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
           
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func saveItem() {
        do
        {
            try context.save()
        }catch{
            print("Error saving context \(error)")
        }
    }
    
}

