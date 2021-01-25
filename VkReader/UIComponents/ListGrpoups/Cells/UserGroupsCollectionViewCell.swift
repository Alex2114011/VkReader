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
    
    var model:ContainerCollectionViewCellModel?
    weak var delegate: VKReaderAbstractCellDelegate?
    var groupImageTask: URLSessionDataTask?
    
    func setupUI() {
        groupImageView.layer.cornerRadius = 50
    }
    
    func configure(with object: VKReaderViewModelCell) {
        guard let model = object as? ContainerCollectionViewCellModel else { fatalError("object empty")  }
        self.model = model
        nameGroupLabel.text = model.item.name
        if let url = NSURL(string: model.item.photo100 ?? "") {
            groupImageTask = ImageCache.shared.load(url: url, callback: { [weak self] (image) in
                self?.groupImageView.image = image
            })
            groupImageTask?.resume()
        }
        nameGroupLabel.text = model.item.name
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
