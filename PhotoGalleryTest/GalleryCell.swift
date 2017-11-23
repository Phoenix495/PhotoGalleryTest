//
//  GalleryCell.swift
//  PhotoGalleryTest
//
//  Created by Phoenix on 23.11.17.
//  Copyright © 2017 Phoenix_Dev. All rights reserved.
//

import UIKit

class GalleryCell: UICollectionViewCell {
    //MARK: - Properties
    
    let photoView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.red
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        return view
    }()
    
    let imageName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Image name"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
    let imageSizeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1000x1000"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    let hashLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "hash"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - Configuration
    
    func setupViews() {
        
        addSubview(photoView)
        addSubview(imageName)
        addSubview(imageSizeLabel)
        addSubview(hashLabel)
        
        // налаштовуємо констрейнти
        // photoView
        photoView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        photoView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        photoView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        //imageName
        imageName.topAnchor.constraint(equalTo: photoView.bottomAnchor).isActive = true
        imageName.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        imageName.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        //imageSizeLabel
        imageSizeLabel.topAnchor.constraint(equalTo: imageName.bottomAnchor).isActive = true
        imageSizeLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        imageSizeLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        //hashLabel
        hashLabel.topAnchor.constraint(equalTo: imageSizeLabel.bottomAnchor).isActive = true
        hashLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        hashLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        hashLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
    
    //MARK:- Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
