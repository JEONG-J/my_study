//
//  ViewController.swift
//  CameraPhotoLibrary
//
//  Created by 정의찬 on 2022/05/20.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    // UIImagePickerController 인스턴스 변수 생성
    var captureImage: UIImage! // 촬영 또는 라이브러리에서 불러온 사진 저장
    var videoURL: URL! // 녹화한 비디오 경로 저정
    var flagImageSave = false // 사진 저장 여부 판독

    @IBOutlet var imgView: UIImageView! // 이미지 보는 뷰
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // 사진 촬영을 위한 액션 함수
    @IBAction func btnCaptureImageFromCamera(_ sender: UIButton) {
        if(UIImagePickerController.isSourceTypeAvailable(.camera)){
            // 카메라 사용이 가능하다면!!
            flagImageSave = true // 이미지 저장 가능
            imagePicker.delegate = self //이미지 피커 델리게이트 셀프
            imagePicker.sourceType = .camera // 소스 타입 카메라로 설정
            imagePicker.mediaTypes = ["public.image"] // 미디어 타입 설정
            imagePicker.allowsEditing = false // 편집 허용 x
            
            present(imagePicker, animated: true, completion: nil) // 현재 뷰에 imagePicker 표시
        }else{
            myAlert("Camera inaccessable", message: "cannot access the camera")
            // 사용이 불가능하다면 경고 표시하기
        }
    }
    
    @IBAction func btnLoadImageFromLibrary(_ sender: UIButton) {
        if(UIImagePickerController.isSourceTypeAvailable(.photoLibrary)){
            // 앨범 사용이 가능하다면!!
            flagImageSave = false // 이미지 저장 여부 끄기
            imagePicker.delegate = self //  이미지 피커 델리게이트 셀프
            imagePicker.sourceType = .photoLibrary // 소스 타입 앨범으로 설정
            imagePicker.mediaTypes = ["public.image"] //미디어 타입 설정
            imagePicker.allowsEditing = true // 편집 허용
        
        
        present(imagePicker, animated: true, completion: nil) // 현재 뷰에 imagePicker 표시
    }else{
        myAlert("Photo album inaccessable", message: "Application cannot access the photo album")
        // 사용이 불가능하다면 경고 표시하기
    }
}
    // 비디오 촬영을 위한 액션 함수
    @IBAction func btnRecordVideoFromCamera(_ sender: UIButton) {
        if(UIImagePickerController.isSourceTypeAvailable(.camera)){
            // 카메라 사용이 가능하다면!!
            flagImageSave = true // 영상 저장 허용
            
            imagePicker.delegate = self // 영상 피커 델리게이트 셀프
            imagePicker.sourceType = .camera //소스 타입 앨범으로 설정
            imagePicker.mediaTypes = ["public.movie"] // 미디어 타입 설정
            imagePicker.allowsEditing = false // 편집 허용
            
            present(imagePicker, animated: true, completion: nil) // 현재 뷰에 imagePicker 표시
        }else{
            myAlert("Camera inaccessable", message: "cannot access the camera")
            // 사용이 불가능하다면 경고 표시하기
        }
    }
    // 비디오 불러오기 액션 함수
    @IBAction func btnLoadVideoFromLibrary(_ sender: UIButton) {
        if(UIImagePickerController.isSourceTypeAvailable(.photoLibrary)){
            // 앨범 사용이 가능하다면!!
            flagImageSave = false // 비디오 저장 여부 끄기
            
            imagePicker.delegate = self // 영상 피커 델리게이트 셀프
            imagePicker.sourceType = .photoLibrary //소스 타입 앨범으로 설정
            imagePicker.mediaTypes = ["public.movie"] // 미디어 타입 설정
            imagePicker.allowsEditing = false // 편집 허용
            
            present(imagePicker, animated: true, completion: nil) // 현재 뷰에 imagePicker 표시
        }else{
            myAlert("Photo album inaccessable", message: "cannot access the photo album")
            // 사용이 불가능하다면 경고 표시하기
        }
    }
    
    // 경고 표시 함수
    func myAlert(_ title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert) // 경고 표시 컨트롤러 설정
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil) // 경고 표시에 활성화할 액션 설정
        alert.addAction(action) // 경고 표시 컨트롤러에 액션 추가
        self.present(alert, animated: true, completion: nil)
    }
    
    // 델리게이트 메서드 구현
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 사용자가 사진이나 비디오 촬영하거나 포토 라이브러리에서 선택이 끝났을 때 호출되는 메서드
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        // 미디어 종류 확인
        if mediaType.isEqual(to: "public.image" as String){
            captureImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        // 사진을 가져와 catureImage에 저장한다.
        
        if flagImageSave{
            UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
        } // 저장이 가능하다면 사진을 앨범에 저장한다.
        
        imgView.image = captureImage
        // 가져온 사진 이미지 뷰에 출력한다.
            
        }else if mediaType.isEqual(to: "public.movie" as String){
            // 미디어 종류가 비디오 일 경우
            if flagImageSave{ // 저장이 가능할 경우
                videoURL = (info[UIImagePickerController.InfoKey.mediaURL] as! URL)
                
                UISaveVideoAtPathToSavedPhotosAlbum(videoURL.relativePath, self, nil, nil)
                // 비디오를 앨범에 저장한다.
            }
        }
        self.dismiss(animated: true, completion: nil)
        // 이미지 피커뷰를 제거하고 초기 뷰를 보여준다.
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
        // 사진안 동영상을 취소할 경우, 뷰 제거하기
    }
}
