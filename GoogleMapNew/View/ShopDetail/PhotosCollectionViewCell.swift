//
//  PhotosCollectionViewCell.swift
//  GoogleMapNew
//
//  Created by Sheng-Yu on 2022/11/7.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    var task:URLSessionDataTask?
    
    @IBOutlet weak var photosImageView: UIImageView!
    func fetchPhotos(photoreference:String,completion:@escaping(UIImage?)->Void){
        let url = URL(string: "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=\(photoreference)&key=\(APIkey)")!
        task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data,
               let response = response as? HTTPURLResponse,
               response.statusCode == 200,
               error == nil{
                let photo = UIImage(data: data)
                completion(photo)
                print("成功抓到圖啦")
            }else{
                completion(nil)
                print("廢物 你沒抓到圖 哈哈")
            }
            //做完就清掉
            self.task = nil
        }
        task?.resume()
    }
    
}
