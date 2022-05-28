//
//  ViewController.swift
//  PageControl
//
//  Created by 정의찬 on 2022/05/11.
//

import UIKit

var images = ["01.png", "02.png", "03.png", "04.png", "05.png", "06.png"]

class ViewController: UIViewController {

    @IBOutlet var imgView: UIImageView!
    @IBOutlet var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pageControl.numberOfPages = images.count // 페이지 컨트롤 수
        pageControl.currentPage = 0 // 페이지 컨트롤의 현재 페이지
        pageControl.pageIndicatorTintColor = UIColor.green // 페이지 컨트롤 색상
        pageControl.currentPageIndicatorTintColor = UIColor.red // 현재 페이지 컨트롤 색상
        imgView.image = UIImage(named: images[0]) // 화면 로드 시 보일 이미지
    }

    @IBAction func pageChange(_ sender: UIPageControl) {
        // 페이지 컨트롤의 현재 페이지에 해당하는 사진 이미지 가져오기
        imgView.image = UIImage(named: images[pageControl.currentPage])
    }
    
}

