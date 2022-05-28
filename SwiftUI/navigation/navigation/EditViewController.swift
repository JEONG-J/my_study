//
//  EditViewController.swift
//  navigation
//
//  Created by 정의찬 on 2022/05/18.
//

import UIKit

//델리 게이트를 위한 프로토콜 추가
protocol EditDelegate{
    func didMessageEditDone(_ controller: EditViewController, message: String)
    func didImageOnOffDone(_ contriller: EditViewController, isOn: Bool)
}


class EditViewController: UIViewController {

    var textWayValue: String = "" // 
    var textMessage: String = "" // 뷰 컨트롤러부터 값을 전달받기 위한 텍스트 변수
    var delegate: EditDelegate? // 프로토콜 사용을 위한 델리게이트 변수 (옵셔널)
    var isOn = false // 스위치 온오프를 위한 불 타입 변수
    
    @IBOutlet var txMessage: UITextField!  // 텍스트 필드 아웃렛 변수
    @IBOutlet var lblWay: UILabel! // 라벨 아웃렛 변수
    
    @IBOutlet var swIsOn: UISwitch! // 스위치 아웃렛 변수
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblWay.text = textWayValue // prepare로 전달받은 값 라벨에 출력
        txMessage.text = textMessage // prepare로 전달받은 텍스트 내용 출력
        swIsOn.isOn = isOn // 온 오프 불타입에 해당하는 스위치 변경
    }
    
    // 완료버튼에 해당하는 액션 함수
    @IBAction func btnDone(_ sender: UIButton){
        // delegate변수에 값이 존재한다면
        if delegate != nil{
            delegate?.didMessageEditDone(self, message: txMessage.text!)
            // 텍스트 필드의 내용 프로토콜로 전달
            delegate?.didImageOnOffDone(self, isOn: isOn)
            //  해당 뷰의 isOn의 값 전달
        }
        _ = navigationController?.popViewController(animated: true)
        // 확인 버튼 눌렀을 때 네비게이션 컨트롤러의 최상단 컨트롤러로 전환
    }
    
    // 스위치 온오프를 통해 isOn 불 타입 변수 값 조정
    @IBAction func swImageOnOff(_ sender: UISwitch) {
        if sender.isOn{
            isOn = true
        }else{
            isOn = false
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
