//
//  DataModel.swift
//  GoogleMapNew
//
//  Created by Sheng-Yu on 2022/11/7.
//

import Foundation

import Foundation
import UIKit

public let APIkey = "AIzaSyDjw_5bt7Zrx0Bs42n2k9c8yUE6BUe-yjg"

//搜尋店家
struct ShopGet:Codable{
    let results:[Results]
}
struct Results:Codable{
    let name:String
    let vicinity:String
    let placeId:String
}

//店家資料
struct DetailResponse:Codable{
    let result:ShopDetail
}
struct ShopDetail:Codable{
    let name:String
    let geometry:Location
    let internationalPhoneNumber:String?
//    let openingHours:OpenTime?
    let reviews:[Reviews]
    let photos:[PhotoGet]
}
struct Location:Codable{
    let location:LocationDetail
}
struct LocationDetail:Codable{
    let lat:Double
    let lng:Double
}
//照片
struct PhotoGet:Codable{
    let photoReference:String
}
//營業時間
//struct OpenTime:Codable{
//    let weekdayText:[String]
//}



//評論
struct Reviews:Codable{
    let authorName:String
    let profilePhotoUrl:String
    let relativeTimeDescription:String
    let text:String
    let time:Date
}

class DataModel{
    
    func fetchShopgetSearch(location:String,keyword:String,completion:@escaping(Result<ShopGet,Error>)->()){
        
        let urlSrl = URL(string: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(location)&radius=1000&keyword=\(keyword)&language=zh-TW&key=\(APIkey)"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        var request = URLRequest(url: urlSrl)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200, error == nil{
                do{
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let responses = try decoder.decode(ShopGet.self, from: data)
                    completion(.success(responses))
                    
                    print("成功搜尋下載資料")
                }
                catch{
                    print("error")
                    completion(.failure(error))
                }
            }
            else{
                print("error")
            }
        }.resume()
    }
    func fetchShopGetDetail(placeId:String,completion:@escaping(Result<DetailResponse,Error>)->()){
        
        let urlSrl = URL(string: "https://maps.googleapis.com/maps/api/place/details/json?place_id=\(placeId)&language=zh-TW&key=\(APIkey)"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        
        var request = URLRequest(url: urlSrl)
        
        print(request)
        
        request.httpMethod = "GET"
        print("request",request.httpMethod!)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200, error == nil{
                print(String(data: data, encoding: .utf8)!)
                
                do{
                    let decoder = JSONDecoder()
                    print(decoder)
                    
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    decoder.dateDecodingStrategy = .secondsSince1970
                    let responses = try decoder.decode(DetailResponse.self, from: data)
                    print("有找到responses",responses)
                    completion(.success(responses))
                    
                    
                    print("成功拿到店家資料")
                }
                catch{
                    do {
                        let decoder = JSONDecoder()
                        let dog = try decoder.decode(DetailResponse.self, from: data)
                        print(dog)
                    } catch DecodingError.keyNotFound(let key, let context) {
                        print("keyNotFound", key, context)
                    } catch DecodingError.typeMismatch(let type, let context) {
                        print("typeMismatch", type, context)
                    } catch DecodingError.valueNotFound(let value, let context) {
                        print("valueNotFound", value, context)
                    } catch DecodingError.dataCorrupted(let context) {
                        print("dataCorrupted", context)
                    } catch  {
                        print(error)
                    }
                    print("沒有拿到店家資料error")
                    completion(.failure(error))
                }
            }
            else{
                print("error")
            }
        }.resume()
    }
    
    func fetchPhoto(url:String,completion:@escaping(UIImage?)->(Void)){
        if let url = URL(string: url){
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200, error == nil{
                    completion(UIImage(data:data))
                }
                else{
                    print("沒有拿到照片",error)
                }
            }.resume()
        }
            
    }
    
    
}
