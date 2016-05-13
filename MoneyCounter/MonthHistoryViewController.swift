//
//  MonthHistoryViewController.swift
//  MoneyCounter
//
//  Created by l08084 on 2016/05/04.
//  Copyright © 2016年 l08084. All rights reserved.
//

import UIKit
import Charts

class MonthHistoryViewController: UIViewController {
    
    @IBOutlet var horizontalBarChartView: HorizontalBarChartView!
    
    var months: [String]!
    
    // 前画面に戻るボタン
    private var backButton = UIButton()
    
    // DBアクセサクラスのインスタンス化
    var repo: Repository = Repository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 各月のテキスト
        months = ["3月", "2月", "1月", "12月", "11月", "10月", "9月", "8月", "7月", "6月", "5月", "4月"]
        
        // 各月支出額合計
        var sumMonth: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        
        horizontalBarChartView.animate(yAxisDuration: 2.0)
        horizontalBarChartView.pinchZoomEnabled = false
        horizontalBarChartView.drawBarShadowEnabled = false
        horizontalBarChartView.drawBordersEnabled = true
        horizontalBarChartView.descriptionText = "月毎の支出量グラフ"
        
        // 戻るボタンのインスタンス化
        backButton = UIButton()
        
        // 戻るボタンを生成する
        backButton.frame = CGRectMake(0, 0, 60, 60)
        backButton.backgroundColor = UIColor.redColor()
        backButton.setTitle("Back", forState: .Normal)
        backButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        backButton.layer.masksToBounds = true
        backButton.layer.cornerRadius = 30.0
        backButton.layer.position = CGPointMake(self.view.frame.width/2, self.view.frame.height-100)
        backButton.addTarget(self, action: #selector(MonthHistoryViewController.onClickbackButton(_:)), forControlEvents: .TouchUpInside)
        
        // 戻るボタンを追加する.
        self.view.addSubview(backButton)
        
        // spendを全件取得する
        let spends = repo.findSpendList()
        
        // NSCalendarインスタンス
        let cal = NSCalendar(identifier: NSCalendarIdentifierGregorian)!
        
        var month: Int = 0
        
        for spend in spends {
            // 支出が何月かを取得
            month = cal.component(.Month, fromDate: spend.spendDate)
            
            // 支出を月ごとに集計
            switch month {
            case 1:
                sumMonth[0] += spend.spendMoney
            case 2:
                sumMonth[1] += spend.spendMoney
            case 3:
                sumMonth[2] += spend.spendMoney
            case 4:
                sumMonth[3] += spend.spendMoney
            case 5:
                sumMonth[4] += spend.spendMoney
            case 6:
                sumMonth[5] += spend.spendMoney
            case 7:
                sumMonth[6] += spend.spendMoney
            case 8:
                sumMonth[7] += spend.spendMoney
            case 9:
                sumMonth[8] += spend.spendMoney
            case 10:
                sumMonth[9] += spend.spendMoney
            case 11:
                sumMonth[10] += spend.spendMoney
            case 12:
                sumMonth[11] += spend.spendMoney
            default: break
                
            }
        }
        setChart(months, values: sumMonth)
    }
    
    
    /// 戻るボタンのアクション時に設定したメソッド
    internal func onClickbackButton(sender: UIButton){
        // 金額入力画面に戻る
        performSegueWithIdentifier("HistoryToMain", sender: nil)
    }
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setChart(dataPoints: [String], values: [Int]) {
        horizontalBarChartView.noDataText = "You need to provide data for the chart."
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: Double(values[i]), xIndex: i)
            
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "支出額(円)")
        let chartData = BarChartData(xVals: months, dataSet: chartDataSet)
        horizontalBarChartView.data = chartData
    }
    
}
