//
//  ViewController.swift
//  Hello
//
//  Created by 정의찬 on 2022/05/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var lblHello: UILabel!
    @IBOutlet var txtName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnSend(_ sender: UIButton) {
        lblHello.text = "hello " + txtName.text!
    }
    /*
     버튼을 통해 text field에 입력된 문자를 전송한다. 그 후 label에 hello + (입력문자)로 출력되게 한다.
     */
    
}

