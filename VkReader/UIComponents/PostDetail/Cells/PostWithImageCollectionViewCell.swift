//
//  PostWithImageCollectionViewCell.swift
//  VkReader
//
//  Created by Alex on 28.12.2020.
//

import UIKit

class PostWithImageCollectionViewCell: UICollectionViewCell, VKReaderAbstractCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var textCommentLabel: UILabel!
    @IBOutlet weak var dateCommentLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var heartImageView: UIImageView!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    var profileImageTask: URLSessionDataTask?
    var model: PostWithImageCellViewModel?
    var imageTask: URLSessionDataTask?
    weak var delegate: VKReaderAbstractCellDelegate?
    
    func setupUI() {
        contentView.backgroundColor = .white
        profileImageView.layer.cornerRadius = 15
    }
    
    func configure(with object: VKReaderViewModelCell) {
        guard let model = object as? PostWithImageCellViewModel else { return }
        self.model = model
        print("Model \(model.profile.firstName)")
        textCommentLabel.text = model.text
        commentCountLabel.text = model.formatNumber(model.likeCounts)
        fullNameLabel.text = ("\(model.profile.firstName ?? "") \(model.profile.lastName ?? "") ")
        if let url = NSURL(string: model.profile.photo50 ?? "") {
            profileImageTask = ImageCache.shared.load(url: url, callback: { [weak self] (image) in
                guard let self = self else { return }
                self.profileImageView.image = image
            })
            profileImageTask?.resume()
        }
        guard let url = NSURL(string: model.imageURLString) else { return }
        imageTask = ImageCache.shared.load(url: url) { [weak self] (image) in
            guard let self = self else { return }
            self.imageView.image = image
        }
        imageTask?.resume()
    }
    
    func set(delegate: VKReaderAbstractCellDelegate) {
        self.delegate = delegate
    }
   
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageTask?.cancel()
        profileImageTask = nil
        imageTask?.cancel()
        imageTask = nil
    }

}
