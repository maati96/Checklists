//
//  ViewController.swift
//  Checklists
//
//  Created by Mohamed Maati on 12/3/18.
//  Copyright © 2018 Mohamed Maati. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, AddItemViewControllerDelegate {
    func addItemViewControllerDidCancel(_ controller: ItemDetailV) {
        navigationController?.popViewController(animated: true)
    }
  
    func addItemViewController(_ controller: ItemDetailV, didFinshEditing item: CheckListItem) {
        if let index = checklist.items.index(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    func addItemViewController(_ controller: ItemDetailV, didFinshAdding item: CheckListItem) {
        let newRowIndex = items.count
       checklist.items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    
    
    var items = [CheckListItem]()
    var checklist: Checklist!
    override func viewDidLoad() {
        super.viewDidLoad()
        
            navigationItem.largeTitleDisplayMode = .never
        title = checklist.name
      
        
    }
    
    
    // MARK:- Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checklist.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Checklistitem", for: indexPath)
        let item = checklist.items[indexPath.row]
        
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = checklist.items[indexPath.row]
            item.toggleChecked()
            
            configureCheckmark(for: cell, with: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func configureCheckmark(for cell: UITableViewCell, with item: CheckListItem) {
        
        let label = cell.viewWithTag(1001) as! UILabel
        if item.checked {
            label.text = "✓"
        } else {
            label.text = ""
        }
    }
    
    func configureText(for cell: UITableViewCell, with item: CheckListItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
        label.text = "\(item.itemID): \(item.text)"
    }

   
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        checklist.items.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    
    // MARK:- Actions
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            let controller = segue.destination as! ItemDetailV
            controller.delegate = self
        } else if segue.identifier == "EditItem" {
            let controller = segue.destination as! ItemDetailV
            controller.delegate = self
            
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.itemToEdit = checklist.items[indexPath.row]
            }
        }
    }
    
    
    
   
    
    
    
}





