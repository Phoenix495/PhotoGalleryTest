//
//  GalleryViewController.swift
//  PhotoGalleryTest
//
//  Created by Phoenix on 23.11.17.
//  Copyright © 2017 Phoenix_Dev. All rights reserved.
//

import UIKit
import Photos
import CryptoSwift

private let reuseIdentifier = "Cell"

class GalleryViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    // створюємо індикатор прогресу
    let progressView: UIProgressView = {
        let view = UIProgressView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.progress = 0
        return view
    }()
    
    // масиви використовуються для збереження інформації про фото отримані з галереї
    var imageAssetArray = [PHAsset]()
    var assetResources = [PHAssetResource]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // дадаємо індикатор прогресу
        view.addSubview(progressView)
        
        // індикатор прогресу розміщується внизу екрану
        progressView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -1).isActive = true
        progressView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        progressView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        // сказужмо назву екрану
        navigationItem.title = "Images"
        // встановлюємо білий колір фону
        self.collectionView?.backgroundColor = UIColor.white
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(GalleryCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        
        // отримуємо інформацію про фото з галереї
        getImageFromPhotoLibrary()
    }

    func getImageFromPhotoLibrary() {
        
        let assets = PHAsset.fetchAssets(with: .image, options: nil)
        print(assets)
        assets.enumerateObjects({ (object, count, stop) in
            self.imageAssetArray.append(object)
            
            let assetResource = PHAssetResource.assetResources(for: object)
            print(assetResource)
            self.assetResources.append(assetResource.last!)
            
        })

    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return imageAssetArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GalleryCell

        //
        let asset = imageAssetArray[indexPath.item]
        let assetResource = assetResources[indexPath.item]
        
        let imageManager = PHImageManager.default()
        
        // отримуємо фото з галереї
        imageManager.requestImageData(for: asset, options: nil) { (resultData, _, _, _) in
            
            if let data = resultData {
                
                let image = UIImage(data: data)
                
                // встановлюємо фото у відповідне imageView
                cell.photoView.image = image
                
                // вказуємо назву фото
                cell.imageName.text = assetResource.originalFilename
                
                // вказуємо розмір та розширення фото
                cell.imageSizeLabel.text = "\(data.count/1024/1024) мб (\(asset.pixelWidth)x\(asset.pixelHeight))"

                DispatchQueue.global(qos: .background).async {
                    // отримуємо md5 hash
                    let hex = data.toHexString()
                    let hash = hex.md5()
                    print(hash)
                    
                    DispatchQueue.main.async {
                        // виводимо hash на екран
                        cell.hashLabel.text = hash
                    }
                }
            }
            
            // підраховуємо прогрес завантаження фото з галереї
            self.progressView.progress += 1.0/Float(self.imageAssetArray.count)
            
            // коли шкала заповнюється повністю ховаємо індикатор
            (self.progressView.progress == 1) ? (self.progressView.isHidden = true) : (self.progressView.isHidden = false)
        }

        
        return cell
    }


    
    //UICollectionDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        // розмір кожної комірки встновлюється рівним 180х180 точок
        return CGSize(width: 180, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        // відстань між клітинками 5 точок
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        // відстань між рядками 5 точок
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        // відступи від країв по 5 точок
        return UIEdgeInsetsMake(5, 5, 5, 5)
    }

}
