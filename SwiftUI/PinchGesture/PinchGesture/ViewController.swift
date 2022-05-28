//
//  ViewController.swift
//  PinchGesture
//
//  Created by 정의찬 on 2022/05/21.
//

import UIKit

class ViewController: UIViewController {
    
    var initialFontSize: CGFloat!

    @IBOutlet var imgPinch: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(ViewController.doPinch(_:)))
        self.view.addGestureRecognizer(pinch)
    }
    
       @objc func doPinch(_ pinch: UIPinchGestureRecognizer){
           imgPinch.transform = imgPinch.transform.scaledBy(x: pinch.scale, y: pinch.scale)
           // 이미지 크기를 조정한다.
           pinch.scale = 1
           // 다음 변환을 위해 스케일 1로 조정
       
           
        }
    }

