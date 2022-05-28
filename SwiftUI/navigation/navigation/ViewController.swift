//
//  ViewController.swift
//  navigation
//
//  Created by 정의찬 on 2022/05/18.
//

import UIKit

class ViewController: UIViewController, EditDelegate {
    // EditDelegate 클래스 지정
    
    
    let imgOn = UIImage(named: "lamp_on.png") // 변수에 이미지 저장
    let imgOff = UIImage(named: "lamp_off.png") // 변수에 이미지 저장
    
    var isOn = true // 전구 on off
    
    @IBOutlet var txMessage: UITextField! // 메시지 입력 아웃렛 변수
    @IBOutlet var imgView: UIImageView! // 이미지 뷰 아웃렛 변수
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imgView.image = imgOn
    }
    
    // 뷰 컨트롤러를 전환하면서 데이터를 전달하기 위한 준비 작업
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let editViewController = segue.destination as! EditViewController
        // 편집화면 세그웨이 값을 저장한다.
        if segue.identifier == "editButton"{ //세그웨이 이름이 editButton일 때 작동
            editViewController.textWayValue = "segue : use button"
            // 편집 화면의 라벨에 위의 문구 출력
        }else if segue.identifier == "editBarButton"{ // 세그웨이 이름이 editBarButton일 때 작
            editViewController.textWayValue = "segue : use Bar button"
        } // 편집 화면의 라벨에 위의 값 출력
        editViewController.textMessage = txMessage.text!
        //뷰 컨트롤러의 텍스트 필드에 있는 값을 편집 화면의 텍스트 필드로 전송
        editViewController.isOn = isOn
        // 뷰 컨트롤의 전구 온오프 값을 뷰 컨트롤의 온오프로 전송
        editViewController.delegate = self
        //편집 화면의 메인 화면으로 전달되게 하기 위한 델리게이트
    }
    
    // 편집 화면의 메시지가 뷰 컨트롤의 텍스트 창으로 전달되게 하기 위함
    func didMessageEditDone(_ controller: EditViewController, message: String) {
        txMessage.text = message
    }
    
    // 편집 화면의 전구 온오프 값이 뷰 컨트롤로 전달되어 이미지 뷰의 이미지 변경
    func didImageOnOffDone(_ contriller: EditViewController, isOn: Bool) {
        if isOn{
            imgView.image = imgOn
        }else{
            imgView.image = imgOff
            self.isOn = false
        }
    }

}

