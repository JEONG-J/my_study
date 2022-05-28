//
//  ViewController.swift
//  PickerView
//
//  Created by 정의찬 on 2022/04/20.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let MAX: Int = 10 // 배열의 크기 지정을 위한 변수
    let PickerViewColumn: Int = 1 // 피커 뷰의 열의 개수
    let PickerViewHeight: CGFloat = 80 //피커뷰의 높이를 지정하는 변수
    var imageArray = [UIImage?]() //파일명에 해당하는 이미지를 출력하기 위해 저장하는 배열
    var imageFileName = ["1.jpg","2.jpg","3.jpg","4.jpg","5.jpg","6.jpg","7.jpg","8.jpg","9.jpg","10.jpg"]
    
    @IBOutlet var pickerImage: UIPickerView! // 선택할 이미지 이름 보여주는 뷰
    @IBOutlet var lblImageFileName: UILabel! // 선택된 이미지 이름 보여주는 레이블
    @IBOutlet var imageView: UIImageView! // 선택된 이미지 보여주는 뷰
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for i in 0 ..< MAX{
            let image = UIImage(named: imageFileName[i])
            imageArray.append(image)
        } // 반복문으로 이미지를 배열에 저장한다.
        
        lblImageFileName.text = imageFileName[0] // 화면이 로드 되었을 때 제일 첫 번째 이미지 이름을 보인다.
        imageView.image = imageArray[0] // 화면이 로드 되었을 때 제일 첫 번째 이미지를 보인다.
    }
    
    // 피커뷰에게 컴포넌트(열의 개수)의 수를 정수값으로 넘겨주는 델리게이트 메서드
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return PickerViewColumn
    }
    // 피커뷰에서 행의 높이를 정수 값으로 넘겨주는 델리게이트 메서드
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return PickerViewHeight
    }
    // 피커뷰에서 행의 개수
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return imageFileName.count
    }
    
    /* 피커뷰의 목록을 이미지 이름으로 출력하기 위함 함수
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return imageFileName[row]
    }*/
    
    // 피코뷰의 목록을 이미지로 나타내기 위함
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let imageView = UIImageView(image: imageArray[row])
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 150)
        
        return imageView
    }

    //피커뷰의 굴렛을 돌려 원하는 열을 선택했을 때 할 일을 델리게이트에게 지시
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        lblImageFileName.text = imageFileName[row] // 선택한 row에 해당하는 사진 이름 저장
        imageView.image = imageArray[row] // 선택한 row에 해당하는 사진 출력
    }

}
