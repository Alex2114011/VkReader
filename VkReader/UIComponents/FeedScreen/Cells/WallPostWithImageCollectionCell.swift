//
//  WallPostWithImageCollectionCell.swift
//  VkReader
//
//  Created by p.grechikhin on 18.11.2020.
//

import UIKit

class WallPostWithImageCollectionCell: UICollectionViewCell, VKReaderAbstractCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var groupImageView: UIImageView!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    
    var model: WallPostWithImageCellViewModel?
    weak var delegate: VKReaderAbstractCellDelegate?
    var imageTask: URLSessionDataTask?
    var groupImageTask: URLSessionDataTask?
    
    func setupUI() {
        contentView.backgroundColor = .white
        groupImageView.layer.cornerRadius = 15
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
    }
    
    func configure(with object: VKReaderViewModelCell) {
        guard let model = object as? WallPostWithImageCellViewModel else { return }
        self.model = model
        postLabel.text = model.text
        if let url = NSURL(string: model.group.photo200 ?? "") {
            groupImageTask = ImageCache.shared.load(url: url, callback: { [weak self] (image) in
                guard let self = self else { return }
                self.groupImageView.image = image
            })
            groupImageTask?.resume()
        }
        groupNameLabel.text = model.group.name
        guard let url = NSURL(string: model.imageURLString) else { return }
        imageTask = ImageCache.shared.load(url: url) { [weak self] (image) in
            guard let self = self else { return }
            self.imageView.image = image
        }
        imageTask?.resume()
        let textHeigth = model.text.height(withConstrainedWidth: UIScreen.main.bounds.width - 20, font: UIFont.systemFont(ofSize: 15))
        self.model?.change(height: textHeigth + 36 + model.imageHeigth)
        imageHeightConstraint.constant = model.imageHeigth
        delegate?.relayout()
    }
    
    func set(delegate: VKReaderAbstractCellDelegate) {
        self.delegate = delegate
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageTask?.cancel()
        imageTask = nil
        groupImageTask?.cancel()
        groupImageTask = nil
    }

}
