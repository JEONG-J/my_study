//
//  ViewController.swift
//  textPinch
//
//  Created by 정의찬 on 2022/05/21.
//

import UIKit

class ViewController: UIViewController {
    
    var initialFontSize: CGFloat!

    @IBOutlet var txtPinch: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(ViewController.doPinch(_:)))
        self.view.addGestureRecognizer(pinch)
    }
    
    @objc func doPinch(_ pinch: UIPinchGestureRecognizer){
        if (pinch.state == UIPinchGestureRecognizer.State.began){
            // 제스처 시작 상태 이면
            initialFontSize = txtPinch.font.pointSize //폰트 초기 사이즈 저장
        }else{
            txtPinch.font = txtPinch.font.withSize(initialFontSize * pinch.scale)
            // 초기 사이즈에서 조정한 사이즈 곱하여 사이즈 조정한다.
        }
    }


}

