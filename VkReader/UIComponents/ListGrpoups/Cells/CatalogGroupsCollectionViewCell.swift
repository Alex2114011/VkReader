//
//  CatalogGroupsCollectionViewCell.swift
//  VkReader
//
//  Created by Alex on 13.01.2021.
//

import UIKit

class CatalogGroupsCollectionViewCell: UICollectionViewCell, VKReaderAbstractCell {
    @IBOutlet weak var groupImageView: UIImageView!
    @IBOutlet weak var nameGroupLabel: UILabel!
    @IBOutlet weak var descriptionAndCountLabel: UILabel!
    @IBOutlet weak var subscribeButton: UIButton!
    
    var model:CatalogGroupsCollectionViewCellModel?
    weak var delegate: VKReaderAbstractCellDelegate?
    var groupImageTask: URLSessionDataTask?
    
    func setupUI() {
        groupImageView.layer.cornerRadius = 25
    }
    
    func configure(with object: VKReaderViewModelCell) {
        guard let model = object as? CatalogGroupsCollectionViewCellModel else { return  }
        self.model = model
        self.descriptionAndCountLabel.text = "\(model.activity), \(model.formatNumber(model.membersCount)) участников"
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


    @IBAction func tappedSubscribe(_ sender: UIButton) {
    }
}
