//
//  ViewController.swift
//  Map
//
//  Created by 정의찬 on 2022/05/11.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    
    @IBOutlet var myMap: MKMapView!
    @IBOutlet var lblLocationInfo1: UILabel!
    @IBOutlet var lblLocationInfo2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        lblLocationInfo1.text = ""
        lblLocationInfo2.text = ""
        locationManager.delegate = self // 델리게이트 셀프
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 정확도 높이기
        locationManager.requestWhenInUseAuthorization() // 위치 추적 사용자 승인 요구
        locationManager.startUpdatingLocation() // 위치 업데이트 시작
        myMap.showsUserLocation = true // 위치 보기 값 true
    }
    // 사용자가 원하는 위도와 경도의 지도만 보여주기 위함(위도, 경도, 범위 크기 지정)
    func goLocation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double) -> CLLocationCoordinate2D{
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue) // 위도 경도 설정
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span) // 지도의 가로 세로 비율
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue) // 설정 값 지도에서 찾는 값
        myMap.setRegion(pRegion, animated: true) // 맵 뷰에 위치 업데이트
        return pLocation
    }
    
    func setAnnotation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double, title strTitle: String, subtitle strSubtitle: String){
        // 위도와 경도에 원하는 핀을 설치한다.
        let annotation = MKPointAnnotation() // 핀을 설치하기 위한 함수 호출
        annotation.coordinate = goLocation(latitudeValue: latitudeValue, longitudeValue: longitudeValue, delta: span) // 위도와 경도 데이터에 핀을 설정한다.
        annotation.title = strTitle // 타이틀 이름을 핀 타이틀 변수에 넘긴다
        annotation.subtitle = strSubtitle // 부타이틀 이름을 핀 부타이틀 변수에 넘긴다.
        myMap.addAnnotation(annotation) // 맵뷰에 핀을 추가한다.
    }
    
    // 위치가 업데이트 되었을 때 지도에 위치 나타내기
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let pLocation = locations.last // 위치가 업데이트 되면 마지막 위치 값 찾아낸다.
        _ = goLocation(latitudeValue: (pLocation?.coordinate.latitude)!, longitudeValue: (pLocation?.coordinate.longitude)!, delta: 0.01) //마지막 위치 값에 해당하는 장소 보여주기
        CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {
            // 위도와 경도를 이용해 역으로 위치의 정보를 찾아온다.
            (placemarks, error) -> Void in
            let pm = placemarks!.first // placemarks의 첫 부분을 가져와 나라 값 추출
            let country = pm!.country
            var address:String = country!
            if pm!.locality != nil{ // 지역과 도로 값이 존재할 경우 주소에 추가한다.
                address += " "
                address += pm!.locality!
            }
            if pm!.thoroughfare != nil{
                address += " "
                address += pm!.thoroughfare!
            }
            self.lblLocationInfo1.text = "현재위치"
            self.lblLocationInfo2.text = address
        })
        
        locationManager.stopUpdatingLocation()
    }

    @IBAction func sgChangeLocation(_ sender: UISegmentedControl) { // 세그먼트 컨트롤을 눌렀을 때 보일 위치를 설정한다.
        if sender.selectedSegmentIndex == 0 {
            self.lblLocationInfo1.text = " "
            self.lblLocationInfo2.text = " "
            locationManager.startUpdatingLocation()
        } else if sender.selectedSegmentIndex == 1{
            setAnnotation(latitudeValue: 37.751853, longitudeValue: 128.87605740000004, delta: 1, title: "강릉", subtitle: "남산초교")
        } else if sender.selectedSegmentIndex == 2{
            setAnnotation(latitudeValue: 37.556876, longitudeValue: 126.914066, delta: 0.1, title: "이지", subtitle: "마포구")
    }
    
}

}
