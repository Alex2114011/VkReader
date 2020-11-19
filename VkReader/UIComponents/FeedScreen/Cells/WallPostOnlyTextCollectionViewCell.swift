//
//  WallPostOnlyTextCollectionViewCell.swift
//  VkReader
//
//  Created by Alex on 19.11.2020.
//

import UIKit

class WallPostOnlyTextCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var groupImageView: UIImageView!
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setupUI() {
        contentView.backgroundColor = .white
        groupImageView.layer.cornerRadius = 15
    }
}
