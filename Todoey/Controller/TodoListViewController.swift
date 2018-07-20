//
//  ViewController.swift
//  Todoey
//
//  Created by Youdo Leam on 12/7/18.
//  Copyright © 2018 Youdo Leam. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController : UITableViewController{
var itemArray = [Item]()
let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
         print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
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
       
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
       
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItem()

       
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem)
    {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) {
            (action) in

            
            let newItem = Item(context:self.context)
            newItem.title = textField.text!
            newItem.done = false
            
            self.itemArray.append(newItem)
            self.saveItem()
            
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
        do{
            try context.save()
            tableView.reloadData()
        }catch{
          print("Error saving context \(error)")
        }
    }
    
    func loadItem ()
    {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do{
             itemArray = try context.fetch(request)
        }catch{
            print("Fetching error \(error)")
        }
    }
    
   
    
}
extension TodoListViewController : UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.predicate = predicate
        
        let sortDecriptor = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sortDecriptor]
        
        do{
            itemArray = try context.fetch(request)
        }catch{
            print("Fetching error \(error)")
        }
         tableView.reloadData()
    }
}

