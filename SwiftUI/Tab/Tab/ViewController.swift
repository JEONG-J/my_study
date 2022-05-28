//
//  ViewController.swift
//  Tab
//
//  Created by 정의찬 on 2022/05/11.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // 탭바가 0부터 시작하고 기본 화면이 0이다. 두 번째 버튼 누르면 이미지 뷰 탭으로 전환
    @IBAction func btnMoveImageView(_ sender: UIButton) {
        tabBarController?.selectedIndex = 1
    }
    // 마찬가지 두 번째 버튼 누르면 피커 데이터 뷰 탭으로 전환
    @IBAction func btnMoveDatePickerView(_ sender: UIButton) {
        tabBarController?.selectedIndex = 2
    }
}

