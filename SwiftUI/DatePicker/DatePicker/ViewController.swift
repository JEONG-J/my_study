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

    @IBOutlet var currentTime: UILabel! // 현재 시간 나타내는 label 아웃렛 변수
    @IBOutlet var pickerTime: UILabel! // 선택 시간 나타내는는 label 아웃렛 변수
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelctor, userInfo: nil, repeats: true) // 타이머 설정하기 위한 함수
    }

    // 시간과 날짜를 출력하여 데이트 피커를 동작시키기 위한 코드
    @IBAction func changeTime(_ sender: UIDatePicker) {
        let datePickerView = sender // 자료형의 인수를 상수에 저장한다 sender는 선택 시간 날짜 데이터 저장
        let formatter = DateFormatter() //날짜를 출력하기 위한 클래스 지정
        formatter.dateFormat = "yyyy-MM-dd HH:mm EEE" // 출력 포맷 설정
        
        pickerTime.text = "선택시간:" + formatter.string(from: datePickerView.date)
        //sender의 데이터를 저장하고 있던 datePickerView의 date를 가져와 string으로 변환 후 formatter 포맷형식으로 출력
    }
    
    @objc func updateTime(){
        let date = NSDate() // 현재 시간을 가져온다.
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        currentTime.text = "현재시간:" + formatter.string(from:date as Date)
        // 현재 시간 데이터를 Date로 패턴 매칭하여 string으로 변환 후 formatter 포맷형식으로 출력
    }
    
}

