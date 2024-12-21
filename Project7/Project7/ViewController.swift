//
//  ViewController.swift
//  Project7
//
//  Created by CANSU ARAR on 4.12.2024.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        //let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        let urlString = "https://hackingwithswift.com/samples/petitions-1.json"
        if let url = try? URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parseJson(json: data)
            }
        }
    }
    
    func parseJson(json: Data) {
        let decoder = JSONDecoder()
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
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

}
