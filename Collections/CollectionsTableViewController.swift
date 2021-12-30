//
//  CollectionsTableViewController.swift
//  Collections
//
//  Created by Vitaly Khryapin on 10.12.2021.
//

import UIKit

class CollectionsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if indexPath.row == 0 {
            cell.textLabel?.text = "Array"
            cell.accessoryType = .disclosureIndicator
        } else if indexPath.row == 1 {
            cell.textLabel?.text = "Set"
            cell.accessoryType = .disclosureIndicator
        } else {
            cell.textLabel?.text = "Dictionary"
            cell.accessoryType = .disclosureIndicator
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let arrayVC = storyboard?.instantiateViewController(identifier: "ArrayCollectionViewController") as! ArrayCollectionViewController
            self.navigationController?.pushViewController(arrayVC, animated: true)
        } else if indexPath.row == 1 {
            let setVC = storyboard?.instantiateViewController(identifier: "SetViewController") as! SetViewController
            self.navigationController?.pushViewController(setVC, animated: true)
        } else if indexPath.row == 2 {
            let dictionaryVC = storyboard?.instantiateViewController(identifier: "DictionaryCollectionViewController") as! DictionaryCollectionViewController
            self.navigationController?.pushViewController(dictionaryVC, animated: true)
        }
    }
}
