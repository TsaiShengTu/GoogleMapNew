//
//  GoogleMapViewController.swift
//  GoogleMapNew
//
//  Created by Sheng-Yu on 2022/11/7.
//

import UIKit
import GoogleMaps

class GoogleMapViewController: UIViewController {
    
    var shopDetail:DetailResponse!

    var withLatitude:Double = 0
    var longitude:Double = 0
    
    var  withLatitudeStart = 24.115769
    var  longitudeStart = 120.679652
    
    
    
    //路徑
    var path: GMSMutablePath!

    @IBOutlet weak var mapView: GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        withLatitude = Double(shopDetail.result.geometry.location.lat)
        print(withLatitude)
        longitude = Double(shopDetail.result.geometry.location.lng)
        print(longitude)
        
        //對於某一地標縮放的比例
        let camera = GMSCameraPosition.camera(withLatitude:withLatitude  , longitude: longitude , zoom: 15)
        mapView.camera = camera
        //地圖樣式
        mapView.mapType = .normal
        
        // Do any additional setup after loading the view.
        
        //地標大頭針
        let marker = GMSMarker()

        marker.position = CLLocationCoordinate2D(latitude: withLatitude , longitude: longitude )
        
        marker.map = mapView
        
        
        //地標標題
        marker.title = shopDetail.result.name
        marker.snippet = ""
        
        self.mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//        mapView.isMyLocationEnabled = true
        
//        let marker1 = GMSMarker()
//                marker.position = CLLocationCoordinate2D(latitude: 25.033671, longitude: 121.564427)
//                marker1.title = "Taiwan"
//                marker1.snippet = "Taipei101"
//                marker1.map = mapView
//
//        //生成路徑
//        self.path = GMSMutablePath()
//        //加入路徑
//        self.path.add(CLLocationCoordinate2D(latitude:withLatitude, longitude: longitude))
//        self.path.add(CLLocationCoordinate2D(latitude:25.033671, longitude: 121.564427))
//
//        //線
//        let line = GMSPolyline(path: self.path)
//        //線 加上mapView
//        line.map = self.mapView
        

//         Do any additional setup after loading the view.
        
//        \(withLatitudeStart),\(longitudeStart)
        //googleMap的呼叫網址
        let url = URL(string: "comgooglemaps://?saddr=&daddr=\(withLatitude),\(longitude)&directionsmode=driving")

                if UIApplication.shared.canOpenURL(url!) {
                    UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                } else {
                    // 若手機沒安裝 Google Map App 則導到 App Store(id443904275 為 Google Map App 的 ID)
                    let appStoreGoogleMapURL = URL(string: "itms-apps://itunes.apple.com/app/id585027354")!
                    UIApplication.shared.open(appStoreGoogleMapURL, options: [:], completionHandler: nil)
                }
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//            // 調整 camera 讓 polyline 的能見度完整顯示在 MapView 上
//            var bounds: GMSCoordinateBounds = GMSCoordinateBounds()
//            for index in 0 ..< path.count() {
//                bounds = bounds.includingCoordinate(path.coordinate(at: index))
//            }
//            self.mapView.animate(with: GMSCameraUpdate.fit(bounds))
//        }
    
    
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
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
