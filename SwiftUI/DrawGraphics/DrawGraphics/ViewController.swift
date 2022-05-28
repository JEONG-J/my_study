//
//  ViewController.swift
//  DrawGraphics
//
//  Created by 정의찬 on 2022/05/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imgView: UIImageView! // 이미지를 보기 위한 뷰 설정
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // 선 버튼 액셔 함수
    @IBAction func btnDrawLine(_ sender: UIButton) {
        UIGraphicsBeginImageContext(imgView.frame.size)
        // 이미지를 그리기 위한 콘텍스트 생성 -> 이미지 뷰의 크기와 맞춘다.
        let context = UIGraphicsGetCurrentContext()!
        // 콘텍스트의 정보를 가져온다.
        context.setLineWidth(2.0) // 선 굵기
        context.setStrokeColor(UIColor.red.cgColor) // 선 색상
        context.move(to: CGPoint(x: 70, y: 50)) // 그림 그리려는 위치 좌표
        context.addLine(to: CGPoint(x: 270, y: 250)) //지정한 위치까지 선 경로를 추가한다.
        
        context.strokePath() // 경로를 콘텍스트에 그린다.
        
        context.setLineWidth(4.0) // 선 굴기
        context.setStrokeColor(UIColor.blue.cgColor) // 선 색상
        context.move(to: CGPoint(x: 170, y: 200)) // 그림 그리려는 위치 이동한다.
        context.addLine(to: CGPoint(x: 270, y: 350)) // 지정한 위치까지 선 경로 추가
        context.addLine(to: CGPoint(x: 70, y: 350)) // 위 좌표에서 지정한 위치까지 선 경로 추가
        context.addLine(to: CGPoint(x: 170, y: 200)) // // 사용이 불가능하다면 경고 표시하기
        // 삼각형 그리기 addLine 3개 추가
        context.strokePath() // 경로 콘텍스트에 그린다.
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        // 콘텍스트의 이미지를 가져와서 뷰에 그린다.
        UIGraphicsEndImageContext() // 그림 그리기를 끝낸다.
    }
    // 사각형 그리기 액션함수
    @IBAction func btnDrawRectangle(_ sender: UIButton) {
        UIGraphicsBeginImageContext(imgView.frame.size)
        // 이미지를 그리기 위한 콘텍스트 생성 -> 이미지 뷰의 크기와 맞춘다.
        let context = UIGraphicsGetCurrentContext()!
        // 콘텍스트의 정보를 가져온다.
        context.setLineWidth(2.0) // 선 굵기
        context.setStrokeColor(UIColor.red.cgColor) // 선 색상
        
        context.addRect(CGRect(x: 70, y: 100, width: 200, height: 200))
        // x y 좌표에서 시작하고 가로 200 세로 200인 사각형을 그린다.
        context.strokePath()
        // 경로 콘텍스트에 그린다.
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        // 콘텍스트의 이미지를 가져와서 그린다.
        UIGraphicsEndImageContext()
        // 그림 그리기를 끝낸다.
    }
    
    // 원 및 타원 그리기 기능 구현한다.
    @IBAction func btnDrawCircle(_ sender: UIButton) {
        UIGraphicsBeginImageContext(imgView.frame.size)
        // 이미지를 그리기 위한 콘텍스트 생성 -> 이미지 뷰의 크기와 맞춘다.
        let context = UIGraphicsGetCurrentContext()!
        // 콘텍스트의 정보를 가져온다.
        context.setLineWidth(2.0) // 선 굵기
        context.setStrokeColor(UIColor.red.cgColor) // 선 색상
        context.addEllipse(in: CGRect(x: 70, y: 50, width: 200, height: 100))
        // x, y 지정 위치에서 가로 200 세로 100인 사각형 안에 내접하는 타원 그린다
        context.strokePath()
        // 경로 콘텍스트에 그린다,
        
        context.setLineWidth(5.0) // 선 굵기
        context.setStrokeColor(UIColor.green.cgColor) // 선 색상 지정
        
        context.addEllipse(in: CGRect(x: 70, y: 200, width: 200, height: 200))
        // x y 지정 위치에서 가로 200, 세로 200인 사각형 안에 내접하는 원을 그린다.
        context.strokePath()
        // 경로 컨테스트에 그린다.
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        // 컨텍스트의 이미지를 가져와서 그린다.
        UIGraphicsEndImageContext()
        // 그림 그리기를 끝낸다.
    }
    
    // 호 그리기 기능 구현
    @IBAction func btnDrawArc(_ sender: UIButton) {
        UIGraphicsBeginImageContext(imgView.frame.size)
        // 이미지를 그리기 위한 콘텍스트 생성 -> 이미지 뷰의 크기와 맞춘다.
        let context = UIGraphicsGetCurrentContext()!
        // 콘텍스트의 정보를 가져온다
        context.setLineWidth(5.0) // 선 굵기
        context.setStrokeColor(UIColor.red.cgColor) // 선 색상
        
        context.move(to: CGPoint(x: 100, y: 50)) // // 그림 그리려는 위치 이동한다.
        context.addArc(tangent1End: CGPoint(x: 250, y: 50), tangent2End: CGPoint(x: 250, y: 200), radius: CGFloat(50))
        // (250,50), (250,200) 사이에 내접한 반지름이 50인 호를 그린다.
        context.addLine(to: CGPoint(x: 250, y: 200))
        // 지정 위치에서 해당 위치까지 선을 그린다.
        context.move(to: CGPoint(x: 100, y: 250))
        context.addArc(tangent1End: CGPoint(x: 270, y: 250), tangent2End: CGPoint(x: 100, y: 400), radius: CGFloat(20))
        context.addLine(to: CGPoint(x: 100, y: 400))
        
        context.strokePath()
        // 경로 콘텍스트에 그린다.
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        // 컨텍스트의 이미지를 가져와서 그린다.
        UIGraphicsEndImageContext()
        // 그림 그리기를 끝낸다.
        
    }
    // 채우기 기능 구현
    @IBAction func btnDrawFill(_ sender: UIButton) {
        UIGraphicsBeginImageContext(imgView.frame.size)
        // 이미지를 그리기 위한 콘텍스트 생성 -> 이미지 뷰의 크기와 맞춘다.
        let context = UIGraphicsGetCurrentContext()!
        // 콘텍스트의 정보를 가져온다
        context.setLineWidth(1.0) // 선 굵기
        context.setStrokeColor(UIColor.red.cgColor) // 선 색상
        context.setFillColor(UIColor.red.cgColor) // 콘텍스트 내부 색상
        
        let rectangle = CGRect(x: 70, y: 50, width: 200, height: 100) // 삼각형 정보 저장
        context.addRect(rectangle) // 콘텍스트에 사각형 저장
        context.fill(rectangle)  // 사각형 내부 색상 칠한다,
        context.strokePath() // 경로 컨텍스트 그리기
        
        context.setLineWidth(1.0) // 선 굵기
        context.setStrokeColor(UIColor.blue.cgColor) // 선 색상
        context.setFillColor(UIColor.blue.cgColor) // 내부 색상
        
        let circle = CGRect(x: 70, y: 200, width: 200, height: 100) // 원 정보 저장
        context.addEllipse(in: circle) // 컨텍스트에 원 그리기
        context.fillEllipse(in: circle) // 원 내부 칠하긴
        context.strokePath() // 경로 컨텍스트 그리기
        
        context.setLineWidth(1.0) // 선 굵기
        context.setStrokeColor(UIColor.green.cgColor) // 선 색상 칠하기
        context.setFillColor(UIColor.green.cgColor) // 내부 색상
        
        context.move(to: CGPoint(x: 170, y: 350)) // 위치 이동
        context.addLine(to: CGPoint(x: 270, y: 450)) // 해당 위치까지 선 그리기
        context.addLine(to: CGPoint(x: 70, y: 450)) //
        context.addLine(to: CGPoint(x: 170, y: 350))
        context.fillPath() // 내부 색 칠하기
        context.strokePath() // 경로 컨텍스트 그리기
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        // 컨텍스트의 이미지를 가져와서 그린다.
        UIGraphicsEndImageContext()
        //그림 그리기 끝낸다
    }
    
}

