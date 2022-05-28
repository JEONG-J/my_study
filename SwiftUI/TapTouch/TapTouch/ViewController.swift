//
//  ViewController.swift
//  TapTouch
//
//  Created by 정의찬 on 2022/05/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var txtMessage: UILabel! // 메시지 출력 아웃렛 변수
    @IBOutlet var txtTapCount: UILabel! // 탭 카운트 아웃렛 변수
    @IBOutlet var txtTouchCount: UILabel! // 터치 횟수 아웃렛 변수
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    /*
     터치 이벤트가 발생했을 때 호출되는 메서드를 재정의 해야한다.
     터치 이벤트가 발생했을 때 호출되는 메서드가 정해져 있다.
     */
    
    // 터치가 시작될 때 호출된다.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch // 발생한 터치 이벤트를 가지고 온다.
        txtMessage.text = "Touches Began"
        txtTapCount.text = String(touch.tapCount)
        txtTouchCount.text = String(touches.count)
    }
    
    // 터치된 손가락이 움직였을 떄 호출
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        
        txtMessage.text = "Touches Moved"
        txtTapCount.text = String(touch.tapCount)
        txtTouchCount.text = String(touches.count)
    }
    
    // 화면에서 손가락을 떼었을 때 호출된다.
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        
        txtMessage.text = "Touches Ended"
        txtTapCount.text = String(touch.tapCount)
        txtTouchCount.text = String(touches.count)
    }


}

