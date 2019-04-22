//
//  DataModel.swift
//  Checklists
//
//  Created by Mohamed Maati on 12/8/18.
//  Copyright © 2018 Mohamed Maati. All rights reserved.
//

import Foundation

class DataModel {
    var lists = [Checklist]()
    
    class func nextChecklistItemID() -> Int {
        let userDefaults = UserDefaults.standard
        let itemID = userDefaults.integer(forKey: "ChecklistItemID")
        userDefaults.set(itemID + 1, forKey: "ChecklistItemID")
        userDefaults.synchronize()
        return itemID
    }
     
    var indexOfSelectedCheckList: Int {
        get {
            return UserDefaults.standard.integer(forKey: "ChecklistIndex")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "ChecklistIndex")
            UserDefaults.standard.synchronize()
        }
    }
    
    func registerDefaults() {
        let dictionary = [ "ChecklistIndex": -1, "FirstTime": true] as [String : Any]
        UserDefaults.standard.register(defaults: dictionary)
    }
    
    
    func handleFirstTime() {
        let userDefaults = UserDefaults.standard
        let firstTime = userDefaults.bool(forKey: "FirstTime")
        
        if firstTime {
            let checklist = Checklist(name: "List")
            lists.append(checklist)
            
            indexOfSelectedCheckList = 0
            userDefaults.set(false, forKey: "FirstTime")
            userDefaults.synchronize()
        }
    }
    init() {
        loadCheckList()
        registerDefaults()
        handleFirstTime()
    }
    // MARK:- Data Saving
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Checklists.plist")
    }
    
    
    
    // this method is now called SaveCheckList()
    
    func saveCheckList() {
        let encoder = PropertyListEncoder()
        do {
            // You encode lists insted of "items"
            let data = try encoder.encode(lists)
            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
        } catch {
            print("Error Encoding list array: \(error.localizedDescription)")
        }
    }
    
    // this method is now called loadCheckList()
    func loadCheckList()  {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                lists = try decoder.decode([Checklist].self, from: data)
                sortChecklists()
            } catch {
                print("Error Decoding list array: \(error.localizedDescription)")
            }
        }
    }
    
    
    
    
    func sortChecklists() {
        lists.sort(by: { list1, list2 in
            return list1.name.localizedStandardCompare(list2.name)
                == .orderedAscending })
    }
    
    
    
    
    
    
    
}
