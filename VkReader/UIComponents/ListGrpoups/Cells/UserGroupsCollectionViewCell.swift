//
//  UserGroupsCollectionViewCell.swift
//  VkReader
//
//  Created by Alex on 11.01.2021.
//

import UIKit

class UserGroupsCollectionViewCell: UICollectionViewCell, VKReaderAbstractCell {

    
    @IBOutlet weak var groupImageView: UIImageView!
    @IBOutlet weak var nameGroupLabel: UILabel!
    
    var model:UserGroupsCollectionViewCellModel?
    weak var delegate: VKReaderAbstractCellDelegate?
    var groupImageTask: URLSessionDataTask?
    
    func setupUI() {
        groupImageView.layer.cornerRadius = 15
    }
    
    func configure(with object: VKReaderViewModelCell) {
        guard let model = object as? UserGroupsCollectionViewCellModel else { return  }
        self.model = model
        nameGroupLabel.text = model.name
        if let url = NSURL(string: model.imageURLString) {
            groupImageTask = ImageCache.shared.load(url: url, callback: { [weak self] (image) in
                self?.groupImageView.image = image
            })
            groupImageTask?.resume()
        }
        nameGroupLabel.text = model.name
    }
    
    func set(delegate: VKReaderAbstractCellDelegate) {
        self.delegate = delegate
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        groupImageTask?.cancel()
        groupImageTask = nil
    }
}
