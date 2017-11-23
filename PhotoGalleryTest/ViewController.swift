//
//  ViewController.swift
//  PhotoGalleryTest
//
//  Created by Phoenix on 23.11.17.
//  Copyright © 2017 Phoenix_Dev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - Properties
    // Створюємо кнопку для відображення галлереї фотографій
    lazy var showGalleryButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show Photo Gallery", for: .normal)
        button.tintColor = UIColor.black
        button.addTarget(self, action: #selector(handleShowGallery), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Configuration
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        // додаємо кнопку на view
        view.addSubview(showGalleryButton)
        
        // налаштовуємо констрейнти кнопки таким чином
        // щоб вона роташовувалась точно посеред екрану
        showGalleryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        showGalleryButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Actions
    
    func handleShowGallery() {
        
        let layout = UICollectionViewFlowLayout()
        let galleryVC = GalleryViewController(collectionViewLayout: layout)
        
        navigationController?.pushViewController(galleryVC, animated: true)
    }


}

