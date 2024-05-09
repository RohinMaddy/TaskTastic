//
//  HomeTableViewController.swift
//  TaskTastic
//
//  Created by Rohin Madhavan on 02/05/2024.
//

import UIKit
import RealmSwift
import ChameleonFramework

class HomeTableViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    var categories: Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        loadCategories()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let navBar = navigationController?.navigationBar else {
            fatalError("Nav bar not present")
        }
        navBar.backgroundColor = UIColor.white
    }
    
    override func deleteFromRealm(at indexPath: IndexPath) {
        do {
            try self.realm.write {
                if let category = self.categories?[indexPath.row] {
                    self.realm.delete(category)
                }
            }
        } catch {
            print("Failed to delete category with error: \(error)")
        }
    }


    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add a new Category", message: "", preferredStyle: .alert)
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "create new Category"
            textField = alertTextField
        }
        
        let action = UIAlertAction(title: "Add", style: .default) { action in
            if let text = textField.text {
                
                let category  = Category()
                category.name = text
                category.color = UIColor.randomFlat().hexValue()
                
                self.save(category: category)
                
                self.tableView.reloadData()
            }
        }
        alert.addAction(action)
        
        present(alert, animated: true)
    }
}

// MARK: - Table view data source

extension HomeTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No category added!"
        if let color =  UIColor(hexString: categories?[indexPath.row].color ?? "FFFFFF") {
            cell.backgroundColor = color
            cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ItemTableViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

// MARK: - Realm Methods

extension HomeTableViewController {
    
    func loadCategories() {
        
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Failed to save category with error: \(error)")
        }
    }
}
