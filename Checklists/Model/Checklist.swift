//
//  Checklist.swift
//  Checklists
//
//  Created by Mohamed Maati on 12/6/18.
//  Copyright © 2018 Mohamed Maati. All rights reserved.
//

import UIKit

class Checklist: NSObject, Codable {
    var name = ""
    var items = [CheckListItem]()
    var iconName = "No Icon"

    
    init(name: String, iconName: String = "No Icon") {
        self.name = name
        self.iconName = iconName
        super.init()
    }
    
    func countUnCheckedItems() -> Int {
        return items.reduce(0) { cnt,
            item in cnt + (item.checked ? 0 : 1 )
        }
    }
}


