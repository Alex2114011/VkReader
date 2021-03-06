//
//  HeaderCatalogCollectionReusableView.swift
//  VkReader
//
//  Created by Alex on 14.01.2021.
//

import UIKit

class HeaderCatalogCollectionReusableView: UICollectionReusableView {
  
    let label:UILabel = {
        let label = UILabel()
        label.text = "МОИ ГРУППЫ"
        return label
    }()
    
    
    func configure() {
        addSubview(label)
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        label.rightAnchor.constraint(equalTo: rightAnchor, constant: 10).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
