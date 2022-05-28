//
//  ViewController.swift
//  imageView
//
//  Created by 정의찬 on 2022/05/22.
//

import UIKit

class ViewController: UIViewController {
    
    var on: UIImage? //이미지 데이터를 저장한 UIImage 타입 변수
    var off: UIImage? //이미지 데이터를 저장한 UIImage 타입 변수
    var zoom: Bool = false // 확대 축소 여부를 위한 참 거짓 변수

    @IBOutlet var imageView: UIImageView! //이미지 뷰 아웃렛 변수
    @IBOutlet var btnResize: UIButton! // 확대 축소 버튼 아웃렛 변수
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        on = UIImage(named: "lamp_on.png") // 이미지 데이터 저장
        off = UIImage(named: "lamp_off.png") // 이미지 데이터 저장
        
        imageView.image = on // 이미지 뷰의 이미지 지정
    }

    @IBAction func btnResizeImage(_ sender: UIButton) {
        let scale: CGFloat = 2.0
        var newWidth: CGFloat, newHeight: CGFloat
        if zoom{ //현재 이미지가 확대 이미지 경우, 축소 시키고 버튼을 확대 버튼으로 변경
            newWidth = imageView.frame.width/scale
            newHeight = imageView.frame.height/scale
            btnResize.setTitle("확대", for: .normal)
        }else{ // 현재 이미지가 축소 이미지 경우, 확대 시키고 버튼을 축소 버튼으로 변경
            newWidth = imageView.frame.width*scale
            newHeight = imageView.frame.height*scale
            btnResize.setTitle("축소", for: .normal)
        }
        imageView.frame.size = CGSize(width: newWidth, height: newHeight)
        // 이미지 뷰의 프레임 크기를 위 사항에 저장된 변수로 변경
        zoom = !zoom // 줌의 값 반전
    }
    
    @IBAction func switchImageOnOff(_ sender: UISwitch) {
        if sender.isOn{ // 스위치가 켜진 경우 on 이미지로 변경
            imageView.image = on
        }else{ // 스위치가 꺼진 경우 off 이미지로 변경
            imageView.image = off
        }
    }
    
}

