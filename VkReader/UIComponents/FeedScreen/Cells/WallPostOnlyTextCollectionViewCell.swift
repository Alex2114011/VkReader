//
//  WallPostOnlyTextCollectionViewCell.swift
//  VkReader
//
//  Created by Alex on 19.11.2020.
//

import UIKit

class WallPostOnlyTextCollectionViewCell: UICollectionViewCell, VKReaderAbstractCell {
    @IBOutlet weak var groupImageView: UIImageView!
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var heartImageView: UIImageView!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var commentsImageView: UIImageView!
    @IBOutlet weak var commentsCountLabel: UILabel!
    @IBOutlet weak var viewsImageView: UIImageView!
    @IBOutlet weak var viewsCountLabel: UILabel!
    
    var groupImageTask: URLSessionDataTask?
    var model: WallPostOnlyTextCellViewModel?
    weak var delegate: VKReaderAbstractCellDelegate?
    
    func setupUI() {
        contentView.backgroundColor = .white
        groupImageView.layer.cornerRadius = 15
    }
    
    func configure(with object: VKReaderViewModelCell) {
        guard let model = object as? WallPostOnlyTextCellViewModel else { return }
        self.model = model
        postLabel.text = model.text
        likesCountLabel.text = model.formatNumber(model.likeCounts)
        commentsCountLabel.text = model.formatNumber(model.commentsCount)
        viewsCountLabel.text = model.formatNumber(model.viewsCount)
        if let url = NSURL(string: model.group.photo200 ?? "") {
            groupImageTask = ImageCache.shared.load(url: url, callback: { [weak self] (image) in
                guard let self = self else { return }
                self.groupImageView.image = image
            })
            groupImageTask?.resume()
        }
        groupNameLabel.text = model.group.name
        let textHeigth = model.text.height(withConstrainedWidth: UIScreen.main.bounds.width - 20, font: UIFont.systemFont(ofSize: 15))
        self.model?.change(height: textHeigth + 89)
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
