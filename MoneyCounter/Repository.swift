//
//  Repository.swift
//  MoneyCounter
//
//  Created by 中安拓也 on 2016/05/02.
//  Copyright © 2016年 l08084. All rights reserved.
//

import Foundation
import RealmSwift

/// DBアクセサクラス
public class Repository {
    
    let realm: Realm
    
    // 初期化処理
    init() {
        
        // デフォルトRealmを取得する
        realm = try! Realm()
        
        // Realmファイルが現在配置されている場所を表示
        print("realm:\(realm.path)")
    }
    
    func saveSpend(spend: Spend) {
        
        try! realm.write {
            
            self.realm.add(spend, update: true)
        }
    }
    
    func findMaxId() -> Int {
        
        let maxId = realm.objects(Spend).sorted("id").last?.id ?? 0
        
        return maxId
    }
    
    func findSpendList() -> Results<Spend> {
        
        let spends = realm.objects(Spend)
        
        return spends
    }
    
}
