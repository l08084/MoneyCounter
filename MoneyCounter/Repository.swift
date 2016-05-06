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
    
    /// spendモデルの保存
    func saveSpend(spend: Spend) {
        
        try! realm.write {
            
            self.realm.add(spend, update: true)
        }
    }
    
    /// Spendモデルの最大IDを取得
    func findMaxIdInSpend() -> Int {
        
        let maxId = realm.objects(Spend).sorted("id").last?.id ?? 0
        
        return maxId
    }
    
    /// Spendを全件取得
    func findSpendList() -> Results<Spend> {
        
        let spends = realm.objects(Spend)
        
        return spends
    }
    
    func findSpendById(id: Int) -> Spend {
        
        let results = realm.objects(Spend).filter("id = %@", id)
        
        return results[0]
    }
    
}
