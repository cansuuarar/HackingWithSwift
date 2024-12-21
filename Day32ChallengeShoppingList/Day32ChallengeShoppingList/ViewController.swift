//
//  ViewController.swift
//  Day32ChallengeShoppingList
//
//  Created by CANSU ARAR on 22.12.2024.
//

import UIKit

class ViewController: UITableViewController {
    
    var shoppingList : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Clear List", style: .plain, target: self, action: #selector(clearList))
    }
    
    
    @objc func addItem() {
        let alertController = UIAlertController(title: "Enter an item", message: nil, preferredStyle: .alert)
        alertController.addTextField()
        
        // weak self: closure'un self'i yani closure'u çağıran nesneyi weak bir şekilde tutmasını sağlar. self, closure u çağıran nesne, closre un bulunduğu class'ın bir instance ıdır
        let submitAction = UIAlertAction(title: "Add an item", style: .default, handler: {
            [weak self, weak alertController]  action in
            guard let response = alertController?.textFields?[0].text else { return }
            self?.shoppingList.insert(response, at: 0)
            //self?.shoppingList.append(response)
            
            // reload the tableview: method1
            let indexPath = IndexPath(row: 0, section: 0)
            self?.tableView.insertRows(at: [indexPath], with: .automatic)
            //method2
            // self?.tableView.reloadData()
        })
        
        alertController.addAction(submitAction)
        present(alertController, animated: true)
        
    }
    
    @objc func clearList() {
        shoppingList.removeAll()
        tableView.reloadData()
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
}



