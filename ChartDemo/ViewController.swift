//
//  ViewController.swift
//  ChartDemo
//
//  Created by kun wang on 2021/12/13.
//

import UIKit
import Charts


class ViewController: UIViewController {

    @IBOutlet weak var chartView: BarChartView!

    override func viewDidLoad() {
        super.viewDidLoad()

        chartView.drawBarShadowEnabled = false
        chartView.drawValueAboveBarEnabled = false

        chartView.maxVisibleCount = 60

        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 10)
        xAxis.granularity = 1
        xAxis.drawGridLinesEnabled = false


        chartView.leftAxis.enabled = false
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.minimumFractionDigits = 0
        leftAxisFormatter.maximumFractionDigits = 1
        leftAxisFormatter.negativeSuffix = " $"
        leftAxisFormatter.positiveSuffix = " $"

        let rightAxis = chartView.rightAxis
        rightAxis.enabled = true
        rightAxis.labelFont = .systemFont(ofSize: 10)
        rightAxis.labelCount = 8
        rightAxis.drawGridLinesEnabled = false
        rightAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
        rightAxis.spaceTop = 0.15
        rightAxis.axisMinimum = 0

        setDataCount(6, range: 100)

        /// a trick for offseted x grid line
        for i in (1..<9) {
            let line = ChartLimitLine(limit: Double(i)-0.4)
            line.lineColor = .gray
            xAxis.addLimitLine(line)
        }
    }

    func setDataCount(_ count: Int, range: UInt32) {
        let start = 1

        let yVals = (start..<start+count+1).map { (i) -> BarChartDataEntry in
            let val = Double(arc4random_uniform(range))
            let val2 = Double(arc4random_uniform(range))
            return BarChartDataEntry(x: Double(i), yValues: [val, val2])
        }

        let set1 = BarChartDataSet(entries: yVals, label: "The year 2017")
        set1.colors = ChartColorTemplates.material()
        set1.drawValuesEnabled = false

        let data = BarChartData(dataSet: set1)
        data.barWidth = 0.6
        chartView.data = data
        chartView.notifyDataSetChanged()
    }


}

