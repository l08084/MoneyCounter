//
//  Spend.swift
//  MoneyCounter
//
//  Created by 中安拓也 on 2016/05/02.
//  Copyright © 2016年 l08084. All rights reserved.
//

import Foundation
import RealmSwift

class Spend: Object {
    
    dynamic var id = 0
    dynamic var spendMoney = 0
    dynamic var spendDate = NSDate()
    dynamic var memo = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
