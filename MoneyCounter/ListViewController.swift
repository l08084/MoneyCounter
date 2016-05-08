//
//  listViewController.swift
//  MoneyCounter
//
//  Created by l08084 on 2016/05/02.
//  Copyright © 2016年 l08084. All rights reserved.
//

import UIKit
import Foundation

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var myTableView: UITableView!
    private var backButton = UIButton()
    
    private var moneyList: [Int] = []
    
    private var spendIdList: [Int] = []
    
    var repo: Repository = Repository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
        
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        
        // Cell名の登録をおこなう.
        myTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        // DataSourceの設定をする.
        myTableView.dataSource = self
        
        // Delegateを設定する.
        myTableView.delegate = self
        
        // Viewに追加する
        self.view.addSubview(myTableView)
        
        // 戻るボタンを生成する
        backButton = UIButton()
        backButton.frame = CGRectMake(0, 0, 60, 60)
        backButton.backgroundColor = UIColor.redColor()
        backButton.setTitle("Back", forState: .Normal)
        backButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        backButton.layer.masksToBounds = true
        backButton.layer.cornerRadius = 30.0
        backButton.layer.position = CGPointMake(self.view.frame.width/2, self.view.frame.height-100)
        backButton.addTarget(self, action: #selector(ListViewController.onClickbackButton(_:)), forControlEvents: .TouchUpInside)
        
        // 戻るボタンを追加する.
        self.view.addSubview(backButton)
        
        repo = Repository()
        
        let spends = repo.findSpendList()
        
        for spend in spends {
            moneyList.append(spend.spendMoney)
            spendIdList.append(spend.id)
        }
    }
    
    
    /// 戻るボタンのアクション時に設定したメソッド
    internal func onClickbackButton(sender: UIButton){
        performSegueWithIdentifier("goMoneyInput", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// Cellが選択された際に呼び出されるデリゲートメソッド.
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // AppDelegateを定義
        var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        // 選択したspendのIDをAppDelegateに渡す
        appDelegate.selectSpendId = spendIdList[indexPath.row]
        
        performSegueWithIdentifier("listToDetail", sender: nil)
    }
    
    
    /// Cellの総数を返すデータソースメソッド
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moneyList.count
    }
    
    /// Cellに値を設定するデータソースメソッド
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // 再利用するCellを取得する.
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath)
        
        // Cellに値を設定する.
        cell.textLabel!.text = "\(moneyList[indexPath.row])円"
        
        return cell
        }
    
    }