//
//  ViewController.swift
//  Audio
//
//  Created by BeomGeun Lee on 2021.
//

import UIKit
import AVFoundation // 오디오 재생을 위한 import

class ViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    //오디오 재생을 위한 델리게이트 클래스 지정
    
    var audioPlayer : AVAudioPlayer! // 오디오 플레이 인스턴스 변수
    var audioFile : URL! //재생할 오디오 파일명 변수
    
    let MAX_VOLUME : Float = 10.0 // 최대 볼륨, 실수형 상수
    
    var progressTimer : Timer! // 프로그레스 타이머를 위한 변수
    
    let timePlayerSelector:Selector = #selector(ViewController.updatePlayTime)
    //현재 뷰의 함수를 선택자로 만든다 -> 시간을 표시하기 위함
    let timeRecordSelector:Selector = #selector(ViewController.updateRecordTime)

    @IBOutlet var pvProgressPlay: UIProgressView! // 진행상태 프로그레스 아웃렛 변수
    @IBOutlet var lblCurrentTime: UILabel! // 재생 현재 시간 아웃렛 변수
    @IBOutlet var lblEndTime: UILabel! //재생 최대 시간 아웃렛 변수
    @IBOutlet var btnPlay: UIButton! // 플레이 버튼 아윳렛 변수
    @IBOutlet var btnPause: UIButton! // 초기화 버튼 아웃렛 변수
    @IBOutlet var btnStop: UIButton! // 정지 버튼 아웃렛 변수
    @IBOutlet var slVolume: UISlider! // 볼륨 조절 슬라이드 변수
    
    @IBOutlet var btnRecord: UIButton! // 시간 앞 레코드 아웃렛 변수
    @IBOutlet var lblRecordTime: UILabel! // 레코드 시간 아웃렛 변수
    
    var audioRecorder : AVAudioRecorder! // 오디오 녹음 인스턴스 추가
    var isRecordMode = false // 레코드 또는 오디오 모드 선택
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        selectAudioFile()
        if !isRecordMode { // 녹음 모드 아닐 경우
            initPlay() // 오디오 초기화 하기
            btnRecord.isEnabled = false // 녹음 버튼 비활성화
            lblRecordTime.isEnabled = false // 녹음 시간 비활성화
        } else { // 녹음 모드 경우
            initRecord() // 녹음 초기화 하기
        }
    }
    
    func selectAudioFile() {
        if !isRecordMode { //녹음 모드가 아닐경우
            audioFile = Bundle.main.url(forResource: "Sicilian_Breeze", withExtension: "mp3")
            // 오디오 파일 지정(메뉴에 있는 파일 지정을 위한 Bundle.main.url(forResource:"이름", withExtension: "확장자")
        } else { // 녹음 모드 일 경우
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] //녹음 파일 생성 경로 지정
            audioFile = documentDirectory.appendingPathComponent("recordFile.m4a") // 파일 이름 설정 하여 추가한다.
        }
    }
    
    func initRecord() {
        
        // 녹음 관련 레코드 설정 옵션
        let recordSettings = [
        AVFormatIDKey : NSNumber(value: kAudioFormatAppleLossless as UInt32),
        AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue,
        AVEncoderBitRateKey : 320000,
        AVNumberOfChannelsKey : 2,
        AVSampleRateKey : 44100.0] as [String : Any]
        
        // 생성된 오디오 파일있으면 설정 값으로 새팅하기
        do {
            audioRecorder = try AVAudioRecorder(url: audioFile, settings: recordSettings)
        } catch let error as NSError { // 없으면 오류 출력하기
            print("Error-initRecord : \(error)")
        }
        audioRecorder.delegate = self // 녹음 델리게이트 위임하기
        slVolume.value = 1.0 // 녹음 볼륨 초기화
        audioPlayer.volume = slVolume.value // 현재 볼륨으로 녹음 볼륨 지정하기
        lblEndTime.text = convertNSTimeInterval2String(0) // 녹음 시간 초기화
        lblCurrentTime.text = convertNSTimeInterval2String(0) // 녹음 시간 초기화
        setPlayButtons(false, pause: false, stop: false) // 오다오 재생 버튼 전체 비활성화
        
        // 원하는데로 오디오를 사용하기 위항 세션 지정
        let session = AVAudioSession.sharedInstance()
        do {
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error as NSError {
            print(" Error-setCategory : \(error)")
        }
        do {
            try session.setActive(true)
        } catch let error as NSError {
            print(" Error-setActive : \(error)")
        }
    }
    
    // 오디오 재생을 위한 초기화 과정
    func initPlay() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFile) //오디오 파일 있으면 가져오기
        } catch let error as NSError {
            print("Error-initPlay : \(error)") // 파일이 없다면 오류 츌력
        }
        slVolume.maximumValue = MAX_VOLUME // 슬라이드 값 최대치 지정
        slVolume.value = 1.0 // 볼륨 슬라이드 기본 값 지정
        pvProgressPlay.progress = 0 // 프로그레스 진행 초기화
        
        audioPlayer.delegate = self // 오디오 플레이 위임 받기
        audioPlayer.prepareToPlay() // 실행하기
        audioPlayer.volume = slVolume.value // 슬라이드 볼륨 값 오디오 볼륨에 지정하기
        
        lblEndTime.text = convertNSTimeInterval2String(audioPlayer.duration) //전체 재생시간을 표시한다.
        lblCurrentTime.text = convertNSTimeInterval2String(0) //시작 시간 0으로 초기화
        setPlayButtons(true, pause: false, stop: false) // 재생 버튼 활성화
    }
    
    // 각각의 버튼 제어하기 위한 지정
    func setPlayButtons(_ play:Bool, pause:Bool, stop:Bool) {
        btnPlay.isEnabled = play
        btnPause.isEnabled = pause
        btnStop.isEnabled = stop
    }
    
    func convertNSTimeInterval2String(_ time:TimeInterval) -> String {
        let min = Int(time/60) // 재생 시간으 60으로 나누 몫의 값 지정
        let sec = Int(time.truncatingRemainder(dividingBy: 60)) //60으로 나눈 나머지 값 정수로 반환하여 초로 지정
        let strTime = String(format: "%02d:%02d", min, sec) // 문자열 포맷을 바꿔 초기화
        return strTime
    }

    @IBAction func btnPlayAudio(_ sender: UIButton) {
        audioPlayer.play() // 오디오 시작
        setPlayButtons(false, pause: true, stop: true) // 플레이 버튼 제외 전체 활성화
        progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timePlayerSelector, userInfo: nil, repeats: true) // 오디오 진행 중 시간 표시를 위함
    }
    
    @objc func updatePlayTime() {
        lblCurrentTime.text = convertNSTimeInterval2String(audioPlayer.currentTime)
        // 오디오의 현재 시간을 표시한다.
        pvProgressPlay.progress = Float(audioPlayer.currentTime/audioPlayer.duration)
    } // 전체 시간에서 현재 시간을 나눈 값을 프로그레스에 표시한다.
    
    @IBAction func btnPauseAudio(_ sender: UIButton) {
        audioPlayer.pause() // 오디오 일시 정지하기
        setPlayButtons(true, pause: false, stop: true)
    }
    
    @IBAction func btnStopAudio(_ sender: UIButton) {
        audioPlayer.stop() // 오디오 전체 정지
        audioPlayer.currentTime = 0 // 현재 시간 0으로 돌리기
        lblCurrentTime.text = convertNSTimeInterval2String(0) // 시간표시 0으로 바꾸기
        setPlayButtons(true, pause: false, stop: false) // 플레이 버트만 활성화하기
        progressTimer.invalidate() // 프로그레스 데이터 전부 초기화
    }
    
    @IBAction func slChangeVolume(_ sender: UISlider) {
        audioPlayer.volume = slVolume.value // 볼륨 조절
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        progressTimer.invalidate() // 시간 초기화
        setPlayButtons(true, pause: false, stop: false) // 버튼 활성화 변경
    }
    
    // 레코드 스위치 지정
    @IBAction func swRecordMode(_ sender: UISwitch) {
        if sender.isOn {
            audioPlayer.stop() // 레코드가 켜지면 오디오 정지
            audioPlayer.currentTime=0 // 오디오 시잔 0으로 초기화
            lblRecordTime!.text = convertNSTimeInterval2String(0) //레코드 시간 텍스트 0으로 초기화
            isRecordMode = true // 레코드 모드 키기
            btnRecord.isEnabled = true // 레코드 버튼 활성화하기(녹음 가능해짐)
            lblRecordTime.isEnabled = true // 레코드 시간 활성화하기
        } else { // 스위치 꺼져있으면
            isRecordMode = false // 레코드 모드 끄기
            btnRecord.isEnabled = false // 레코드 버튼 비활성화
            lblRecordTime.isEnabled = false // 레코드시간 비활성화
            lblRecordTime.text = convertNSTimeInterval2String(0) // 레코드 시간 0으로 초기화하기
        }
        selectAudioFile() // 오디오 파일을 선택하고 모드에 따라 초기화
        if !isRecordMode {
            initPlay() //레코드 모드 아닐경우 오디오 초기화
        } else {
            initRecord() //레코드 모드일 경우 레코드 초기화
        }
    }
    
    // 녹음하기
    @IBAction func btnRecord(_ sender: UIButton) {
        if (sender as AnyObject).titleLabel?.text == "Record" {
            audioRecorder.record() // 버튼 텍스트가 Record 이면 녹음 시작하기
            (sender as AnyObject).setTitle("Stop", for: UIControl.State()) // 버튼 텍스트 변경
            progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timeRecordSelector, userInfo: nil, repeats: true) // 녹음 시간 초기화하기
        } else { // 버튼 텍스트가 Record가 아니면
            audioRecorder.stop() // 녹음 정지하기
            progressTimer.invalidate() // 시간 초기화하기
            (sender as AnyObject).setTitle("Record", for: UIControl.State()) // 버튼 텍스트 변경
            btnPlay.isEnabled = true // 버튼 활성화하기
            initPlay() // 오디오 초기화하기
        }
    }
    
    @objc func updateRecordTime() {
        lblRecordTime.text = convertNSTimeInterval2String(audioRecorder.currentTime)
        // 오디오의 현재 시간을 표시한다.
    }
    
}

















