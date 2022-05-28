
//
//  ViewController.swift
//  MoviePlayer
//
//  Created by 정의찬 on 2022/05/20.
//

import UIKit
import AVKit
// 비디오 재생을 위한 라이브러리 import 하기
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnPlayInternalMovie(_ sender: UIButton) {
        let filePath: String? = Bundle.main.path(forResource: "FastTyping", ofType: "mp4")
        let url = NSURL(fileURLWithPath: filePath!) // 다른 곳에서 가져올 때 NSURL 사용한다.
        
        playVideo(url: url) //비디오 재생한다.
    }
    
    @IBAction func btnPlayerExternalMovie(_ sender: UIButton) {
        let url = NSURL(string: "https://youtu.be/UAwF5vvphbU")!
        
        playVideo(url: url)
    }
    
    // 비디오 재생을 위한 함수
    private func playVideo(url: NSURL){
        let playerController = AVPlayerViewController() // 비디오 플레이 컨트롤러 생성
        let player = AVPlayer(url: url as URL) // 주소에 해당하는 영상 가져온다.
        playerController.player = player // 비디오 플레이 컨트롤러의 플레이에 가져온 영상을 할당
        self.present(playerController, animated: true){
            player.play() // 비디오 컨트롤러의 비디오를 재생한다.
        }
    }
}
