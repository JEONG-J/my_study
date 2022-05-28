//
//  AddViewController.swift
//  table
//
//  Created by 정의찬 on 2022/05/18.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet var tfAddItem: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnAddItem(_ sender: UIButton) {
        items.append(tfAddItem.text!) // 추가 버튼을 통해 텍스트 라벨에 있는 글 item에 저장
        itemsImageFile.append("clock.png")// 사진 추가
        tfAddItem.text="" // 텍스트 라벨 초기화
        _ = navigationController?.popViewController(animated: true) // 최상단 뷰로 이동
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
