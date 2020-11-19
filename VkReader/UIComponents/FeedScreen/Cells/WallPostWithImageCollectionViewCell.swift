//
//  WallPostWithImageCollectionViewCell.swift
//  VkReader
//
//  Created by Alex on 19.11.2020.
//

import UIKit

class WallPostWithImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var groupImageView: UIImageView!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var groupNameLabel: UILabel!
    /// Создаем оутлет на констрейнт это нужно для того чтобы сделать динимическую высоту view
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupUI() {
        contentView.backgroundColor = .white
        groupImageView.layer.cornerRadius = 15
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
    }
}
