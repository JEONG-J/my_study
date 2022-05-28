//
//  ViewController.swift
//  Sketch
//
//  Created by 정의찬 on 2022/05/21.
//

import UIKit

class ViewController: UIViewController {
    
    var lastPoint: CGPoint! // 직전에 터치하거나 이동한 위치
    var lineSize: CGFloat = 2.0 //선 굵기
    var lineColor = UIColor.red.cgColor // 선 색상

    @IBOutlet var imgView: UIImageView! // 이미지 뷰
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnClearImageView(_ sender: UIButton) {
        imgView.image = nil // 이미지 뷰 초기화 액션 버튼
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        
        lastPoint = touch.location(in: imgView)
        // 터치한 위치를 저장한다.
    }
    
    // 손가락 움직였을 때
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIGraphicsBeginImageContext(imgView.frame.size)
        UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
        UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
        // 선의 끝 모양 라운드로 설정
        UIGraphicsGetCurrentContext()?.setLineWidth(lineSize)
        // 컨텍스트 설정
        
        let touch = touches.first! as UITouch
        let currentPoint = touch.location(in: imgView)
        
        imgView.image?.draw(in: CGRect(x: 0, y: 0, width: imgView.frame.size.width, height: imgView.frame.size.height))
        // 이미지 뷰에 있는 이미지를 뷰의 크기로 그린다.
        
        UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
        // 마지막 터치 위치로 이동
        UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: currentPoint.x, y: currentPoint.y))
        // 현재 터치 위치까지 컨텍스트 그린다.
        UIGraphicsGetCurrentContext()?.strokePath()
        // 컨텍스트 경로 그린다.
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        // 이미지 뷰에 컨텍스트 그림 그린다.
        UIGraphicsEndImageContext()
        // 그림 그리기 종료
        
        lastPoint = currentPoint
        // 현재 위치가 마지막 위치로 변한다.
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIGraphicsBeginImageContext(imgView.frame.size)
        UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
        UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
        UIGraphicsGetCurrentContext()?.setLineWidth(lineSize)
        
        imgView.image?.draw(in: CGRect(x: 0, y: 0, width: imgView.frame.size.width, height: imgView.frame.size.height))
        
        UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
        UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
        UIGraphicsGetCurrentContext()?.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    // 기기 흔들었을 대 액션
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake{
            imgView.image = nil
        }
    }
    
}

