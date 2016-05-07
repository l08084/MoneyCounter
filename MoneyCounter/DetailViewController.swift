//
//  DetailViewController.swift
//  MoneyCounter
//
//  Created by 中安拓也 on 2016/05/05.
//  Copyright © 2016年 l08084. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var myTableView: UITableView!
    private var myButton = UIButton()
    
    private var spendInfo: [String] = []
    
    var repo: Repository = Repository()
    
    var selectSpendId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
        
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        
        // Cell名の登録をおこなう
        myTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        // DataSourceの設定をする
        myTableView.dataSource = self
        
        // Delegateを設定する
        myTableView.delegate = self
        
        // Viewに追加する
        self.view.addSubview(myTableView)
        
        myButton = UIButton()
        
        // ボタンを生成する
        myButton.frame = CGRectMake(0, 0, 60, 60)
        myButton.backgroundColor = UIColor.redColor()
        myButton.setTitle("Back", forState: .Normal)
        myButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        myButton.layer.masksToBounds = true
        myButton.layer.cornerRadius = 30.0
        myButton.layer.position = CGPointMake(self.view.frame.width/2, self.view.frame.height-100)
        myButton.addTarget(self, action: #selector(ListViewController.onClickMyButton(_:)), forControlEvents: .TouchUpInside)
        
        // ボタンを追加する.
        self.view.addSubview(myButton)
        
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let spendId = appDelegate.selectSpendId
        print("selectSpendId:\(spendId)")
        
        var selectSpend = repo.findSpendById(spendId!)
        
        let format = NSDateFormatter()
        
        format.dateFormat = "yyyy/MM/dd HH:mm"
        
        spendInfo.append("\(selectSpend.spendMoney)円")
        spendInfo.append("\(format.stringFromDate(selectSpend.spendDate))")
        spendInfo.append(selectSpend.location)
        spendInfo.append("メモ:\(selectSpend.memo)")
    }
    
    /*
     ボタンのアクション時に設定したメソッド.
     */
    internal func onClickMyButton(sender: UIButton){
        performSegueWithIdentifier("detailToList", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
     Cellが選択された際に呼び出されるデリゲートメソッド.
     */
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {}
    
    /*
     Cellの総数を返すデータソースメソッド.
     (実装必須)
     */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spendInfo.count
    }
    
    /*
     Cellに値を設定するデータソースメソッド.
     (実装必須)
     */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // 再利用するCellを取得する.
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath)
        
        // Cellに値を設定する.
        cell.textLabel!.text = "\(spendInfo[indexPath.row])"
        
        return cell
    }
    
}
