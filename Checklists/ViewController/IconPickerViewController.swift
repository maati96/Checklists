//
//  IconPickerViewController.swift
//  Checklists
//
//  Created by Mohamed Maati on 12/8/18.
//  Copyright © 2018 Mohamed Maati. All rights reserved.
//

import UIKit

protocol IconPickerViewControllerDeletage: class {
    func iconPicker(_ picker: IconPickerViewController, didpick iconName: String)
}

class IconPickerViewController: UITableViewController {
    weak var delegate: IconPickerViewControllerDeletage?
    
    
    let icons = [ "No Icon", "Appointments", "Birthdays", "Chores",
    "Drinks", "Folder", "Groceries", "Inbox", "Photos", "Trips" ]
    
   
    // MARK:- Table View Delegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return icons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "IconCell", for: indexPath)
        let iconName = icons[indexPath.row]
        cell.textLabel!.text = iconName
        cell.imageView!.image = UIImage(named: iconName)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate = delegate {
            let iconName = icons[indexPath.row]
            delegate.iconPicker(self, didpick: iconName)
        }
    }
}
