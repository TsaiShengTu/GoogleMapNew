//
//  ShopDetailViewController.swift
//  GoogleMapNew
//
//  Created by Sheng-Yu on 2022/11/7.
//

import UIKit

class ShopDetailViewController: UIViewController {
    
    var item:Results!
    
    var detail:DetailResponse?
    
    let listController = DataModel()
    
    
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    @IBOutlet weak var shopDetailTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        shopDetailTableView.delegate = self
        shopDetailTableView.dataSource = self
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        print("item123\(item.placeId)")
        
        listController.fetchShopGetDetail(placeId: item.placeId){
            result in
        switch result{
        case.success(let response):
            self.detail = response
            DispatchQueue.main.async {
                self.shopDetailTableView.reloadData()
                self.photoCollectionView.reloadData()
                print("detail載入")
                print(self.detail?.result.geometry.location.lat)
                print(self.detail?.result.geometry.location.lng)
            }
        case.failure(_):
            print("DetailError")
            }
        }

        // Do any additional setup after loading the view.

    }
    
    @IBSegueAction func goToMap(_ coder: NSCoder, sender: Any?, segueIdentifier: String?) -> GoogleMapViewController? {
        let controller =  GoogleMapViewController(coder: coder)
        controller?.shopDetail = detail
        return controller
    }
    
    @IBAction func goToMap(_ sender: Any) {
        performSegue(withIdentifier: "goToMap", sender: nil)
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
//傳值






extension ShopDetailViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detail?.result.photos.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as! PhotosCollectionViewCell
        cell.photosImageView.image = nil
        cell.fetchPhotos(photoreference: detail?.result.photos[indexPath.row].photoReference ?? "") { image in
            DispatchQueue.main.async{
                cell.photosImageView.image = image
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? PhotosCollectionViewCell{
            cell.task?.cancel()
            cell.task = nil
        }
    }
    
    
}

extension ShopDetailViewController:UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        detail?.result.reviews.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopDetailTableViewCell", for: indexPath) as! ShopDetailTableViewCell
        cell.reviews = detail?.result.reviews[indexPath.row]
        cell.updateShopDetail()
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         tableView.deselectRow(at: indexPath, animated: true)
    }
}
