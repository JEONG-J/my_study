//
//  ViewController.swift
//  AleterView
//
//  Created by 정의찬 on 2022/04/23.
//

import UIKit

class ViewController: UIViewController {

    let imgOn = UIImage(named: "lamp-on.png") // 켜진 전구 사진을 저장하기 위한 변수
    let imgOff = UIImage(named: "lamp-off.png") // 꺼진 전구 사진을 저장하기 위한 변수
    let imgRemove = UIImage(named: "lamp-remove.png") //사라진 전구 사진을 저장하기 위한 변수

    var isLampOn: Bool = true // 전구가 켜져있다는 사실을 알리기 위한 불타입
    
    @IBOutlet var lampImg: UIImageView! // 전구 사진 출력을 위한 이미지 뷰 변수
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        lampImg.image = imgOn // 화면이 로드 되면 켜진 전구 사진을 보여준다.
    }

    @IBAction func btnLampOn(_ sender: UIButton) {
        if isLampOn{
            let lampOnAlert = UIAlertController(title: "경고", message: "현재 On", preferredStyle: UIAlertController.Style.alert)
            //UIController에 alter 옵션을 설정한다.
            let lampAction = UIAlertAction(title: "네", style: UIAlertAction.Style.default, handler: nil)
            //alert가 표시됐을 때 선택 옵션을 설정한다.
            lampOnAlert.addAction(lampAction)
            // alter 옵션을 설정한 거에 선택 옵션을 추가한다.
            present(lampOnAlert, animated: true, completion: nil)
            //화면에 보인다.
        } else{ // 전구가 꺼져있다면 전구 이미지를 킨 상태로 바꾸고, 켜진 true값으로 변경
            lampImg.image = imgOn
            isLampOn = true
        }
    }
    
    @IBAction func btnLampOff(_ sender: UIButton) {
        if isLampOn{
            let lampOffAlert = UIAlertController(title: "램프 끄지", message: "끌까요?", preferredStyle: UIAlertController.Style.alert)
            // 전구를 끌지 묻는 alter 옵션을 설정한다.
            let OffAction = UIAlertAction(title: "네", style: UIAlertAction.Style.default, handler: {ACTION in self.lampImg.image = self.imgOff
                self.isLampOn = false
            }) // 익명함수를 사용하여 전구 끄기 버튼을 누르면 켜진 전구 사진이 꺼진 전구 사진으로 바뀌도록 한다.
            let cancelAction = UIAlertAction(title: "아니요", style: UIAlertAction.Style.default, handler: nil) // 아니요 버튼을 생성한다.
            
            lampOffAlert.addAction(OffAction)
            lampOffAlert.addAction(cancelAction)
            // 생성한 버튼을 alertController에 삽입한다.
            present(lampOffAlert, animated: true, completion: nil)
            // 경고창을 화면에 보이게 한다.
        }
    }
    @IBAction func btnLampRemove(_ sender: UIButton) {
        let lampRemoveAlert = UIAlertController(title: "삭제", message: "제거할래요?", preferredStyle: UIAlertController.Style.alert)
        // 전구 삭제 alter 옵션을 설정한다.
        let offAction = UIAlertAction(title: "아니요 끕니다", style: UIAlertAction.Style.default, handler: {ACTION in self.lampImg.image = self.imgOff
            self.isLampOn = false
        })
        // 전구 끄기 버튼 옵션을 만든다.
        let onAction = UIAlertAction(title: "아니요, 켭니다", style: UIAlertAction.Style.default, handler: {ACTION in self.lampImg.image = self.imgOn
            self.isLampOn = true
        })
        // 전구 켜기 버튼 옵션을 만든다.
        let removeAction = UIAlertAction(title: "네", style: UIAlertAction.Style.destructive, handler: {ACTION in self.lampImg.image = self.imgRemove
            self.isLampOn = false
        })
        // 전구 삭제 버튼 옵션을 만든다.
        lampRemoveAlert.addAction(offAction)
        lampRemoveAlert.addAction(onAction)
        lampRemoveAlert.addAction(removeAction)
        // 버튼 옵션을 alertController에 삽입한다.
        
        present(lampRemoveAlert, animated: true, completion: nil)
        // 경고창을 화면에 보인다.
    }
    
}

