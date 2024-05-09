//
//  ItemTableViewController.swift
//  TaskTastic
//
//  Created by Rohin Madhavan on 07/05/2024.
//

import UIKit
import RealmSwift
import ChameleonFramework

class ItemTableViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    var items: Results<Item>?
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let color = selectedCategory?.color {
            title = selectedCategory!.name
            guard let navBar = navigationController?.navigationBar else {
                fatalError("Nav bar not present")
            }
            navBar.backgroundColor = UIColor(hexString: color)
        }
    }
    
    
    override func deleteFromRealm(at indexPath: IndexPath) {
        do {
            try self.realm.write {
                if let item = self.items?[indexPath.row] {
                    self.realm.delete(item)
                }
            }
        } catch {
            print("Failed to delete category with error: \(error)")
        }
    }
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add a new Item", message: "", preferredStyle: .alert)
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "create new Item"
            textField = alertTextField
        }
        
        let action = UIAlertAction(title: "Add", style: .default) { action in
            if let text = textField.text, let category = self.selectedCategory {
                
                do {
                    try self.realm.write {
                        let item  = Item()
                        item.title = text
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
                        item.dateCreated = dateFormatter.string(from: Date())
                        category.items.append(item)
                    }
                } catch {
                    print("Failed to save item with error: \(error)")
                }
    
                self.tableView.reloadData()
            }
        }
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    
    func loadItems() {
        
        items = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
    }
}

// MARK: - Search bar delegate methods

extension ItemTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        items = items?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
}

// MARK: - Table view data source

extension ItemTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 1
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if let item = items?[indexPath.row] {
            cell.textLabel?.text = item.title
            let gradient: CGFloat = (CGFloat(indexPath.row) / CGFloat(items!.count))
            if let color = UIColor(hexString: selectedCategory?.color ?? "FFFFFF")?.darken(byPercentage: gradient) {
                cell.backgroundColor = color
                cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
            }
            cell.accessoryType = item.done ? .checkmark : .none
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.cellForRow(at: indexPath)?.accessoryType = tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark ? .none : .checkmark
        if let item = items?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                }
            } catch {
                print("Failed updating items done status with error \(error)")
            }
        }
        
        tableView.reloadData()
    }
}
