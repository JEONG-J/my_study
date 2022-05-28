//
//  ViewController.swift
//  DatePicker
//
//  Created by 정의찬 on 2022/04/19.
//

import UIKit

class ViewController: UIViewController {
    let timeSelctor: Selector = #selector(ViewController.updateTime)
    let interval = 1.0
    var count = 0

    @IBOutlet var currentTime: UILabel!
    @IBOutlet var pickerTime: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelctor, userInfo: nil, repeats: true)
    }

    @IBAction func changeTime(_ sender: UIDatePicker) {
        let datePickerView = sender
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm EEE"
        
        pickerTime.text = "선택시간:" + formatter.string(from: datePickerView.date)
    }
    
    @objc func updateTime(){
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        currentTime.text = "현재시간:" + formatter.string(from:date as Date)
    }
    
}

