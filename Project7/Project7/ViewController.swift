//
//  ViewController.swift
//  Project7
//
//  Created by CANSU ARAR on 4.12.2024.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()
    var filteredItems = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString: String
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(creditButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Search a word..", style: .plain, target: self, action: #selector(searchString))
        
        if let url =  URL(string: urlString){
            if let data = try? Data(contentsOf: url) { //contentsOf ile url yi okur ve Data olarak döndürür
                parseJson(json: data)
                return
            }
        }
        showError()
        
        
    }
    
    @objc func creditButton() {
        let ac = UIAlertController()
        ac.addAction(UIAlertAction(title: "Data comes from the We The People API of the Whitehouse", style: .default))
        present(ac, animated: true)
    }
    
    
    @objc func searchString() {
        let ac = UIAlertController(title: "Enter a word", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Enter a word", style: .default, handler: {
            [weak self, weak ac] action in
            guard let input = ac?.textFields?[0].text else { return }
            self?.submit(input: input)
        })
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
   
    func submit(input: String) {
        for petition in petitions {
            if petition.body.contains(input) {
                filteredItems.insert(petition, at: 0)
                petitions.removeAll()
                petitions = filteredItems
                tableView.reloadData()
               
            }
        }
        
    }
    
    
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
    }
    
    func parseJson(json: Data) {
        let decoder = JSONDecoder()
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

