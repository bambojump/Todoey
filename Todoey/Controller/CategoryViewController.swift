//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Youdo Leam on 20/7/18.
//  Copyright © 2018 Youdo Leam. All rights reserved.
//

import UIKit
import CoreData
class CategoryViewController: UITableViewController {
    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        loadItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
            return categoryArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categoryArray[indexPath.row].name

        return cell
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add Category Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) {
            (action) in
            
            let newCategory = Category(context:self.context)
            newCategory.name = textField.text!
            self.categoryArray.append(newCategory)
            self.saveItem()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Category"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    // MARK: - Data Manipulation Methods
    func saveItem ()
    {
        do{
            try context.save()
            tableView.reloadData()
        }catch{
            print("Error saving context \(error)")
        }
    }
    func loadItem (with request:NSFetchRequest<Category> = Category.fetchRequest())
    {
        do{
            categoryArray = try context.fetch(request)
        }catch{
            print("Fetching error \(error)")
        }
        tableView.reloadData()
    }
    // MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
        
    }
    
    
}
