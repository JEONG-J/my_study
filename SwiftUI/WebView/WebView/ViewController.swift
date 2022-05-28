//
//  ViewController.swift
//  WebView
//
//  Created by 정의찬 on 2022/04/23.
//

import UIKit
import WebKit //웹 뷰를 사용하기 위한 import

class ViewController: UIViewController, WKNavigationDelegate { // 액티비티 인디케이터 구현하기

    @IBOutlet var txtUrl: UITextField!
    @IBOutlet var myWebView: WKWebView!
    @IBOutlet var myActivityIndicator: UIActivityIndicatorView!
    
    func loadWebPage(_ url: String){
        let myUrl = URL(string: url)
        let myRequest = URLRequest(url: myUrl!)
        myWebView.load(myRequest)
    } // 웹을 처음 시작할 때 기본적으로 특정 웹 페이지를 보여주기 위한 웹 페이지
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myWebView.navigationDelegate = self // 웹뷰에 액티비티 인디케이터 표시하기 위하
        loadWebPage("http://google.com") // 지정한 웹 페이지 로드하기
    }
    
    // 사이트 접속이 진행 중일때 인디케이터 시작하기
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!){
        myActivityIndicator.startAnimating()
        myActivityIndicator.isHidden = false
    }
    
    // 사이트 접속이 완료ㅑ되면 인디케이터 종료하기
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        myActivityIndicator.stopAnimating()
        myActivityIndicator.isHidden = true
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error){
        myActivityIndicator.stopAnimating()
        myActivityIndicator.isHidden = true
    }
    
    func checkUrl(_ url: String) -> String{ // 문자열 자동 삽입 기능 구현하기
        var strUrl = url
        let flag = strUrl.hasPrefix("https://www.") // 참 거짓 따지기
        if !flag{ // 거짓이면
            strUrl = "https://www." + strUrl // 앞에 문자 추가하기
        }
        return strUrl
    }
    

    // 입력한 주소창으로 접속하기
    @IBAction func btnGoldUrl(_ sender: UIButton) {
        let myUrl = checkUrl(txtUrl.text!) // 텍스트 필드에 입력된 주소 값 넘기기
        txtUrl.text = "" // 텍스트 필드 공백을 초기화
        loadWebPage(myUrl) // 주소 값으로 사이트 이동
       
    }
    
    @IBAction func btnGoSite1(_ sender: UIButton) {
        loadWebPage("http://www.naver.com") // 버튼 1 누르면 네이터 이동
    }
    
    @IBAction func btnGoSite2(_ sender: UIButton) {
        loadWebPage("http://cau.ac.kr") // 버트 2 누르면 중앙대 사이트 이동
    }
    
    @IBAction func BtnLoadHtmlString(_ sender: UIButton) {
        let htmlString = "<h1> HTML String </h1><p> String 변수 이용한 웹 페이지 </p><p><a href=\"http://www.naver.com>NAVER</a>로 이동</p>"
        myWebView.loadHTMLString(htmlString, baseURL: nil)
    }
    
    @IBAction func btnLoadHtmlFIle(_ sender: UIButton) {
        let filePath = Bundle.main.path(forResource: "htmlView", ofType: "html")
        // html 파일 경로 받아오기
        let myUrl = URL(fileURLWithPath: filePath!) // 파일 경로를 주소로 전환
        let myRequest = URLRequest(url: myUrl) // 파일 경로로 주소 요청하기
        myWebView.load(myRequest) // 웹 뷰에 불러오기
    }
    
    @IBAction func btnStop(_ sender: UIBarButtonItem) {
        myWebView.stopLoading() // 로딩 정지 버튼
    }
    
    @IBAction func btnReload(_ sender: UIBarButtonItem) {
        myWebView.reload() // 로딩 재로딩 버튼
    }
    
    @IBAction func btnGoBack(_ sender: UIBarButtonItem) {
        myWebView.goBack() // 이전 페이지 이동 버튼
    }
    
    @IBAction func btnGoForward(_ sender: UIBarButtonItem) {
        myWebView.goForward() // 다음 페이지 이동 버튼
    }
}

