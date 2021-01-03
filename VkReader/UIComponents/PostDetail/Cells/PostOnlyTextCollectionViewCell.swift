//
//  PostOnlyTextCollectionViewCell.swift
//  VkReader
//
//  Created by Alex on 27.12.2020.
//

import UIKit

class PostOnlyTextCollectionViewCell: UICollectionViewCell, VKReaderAbstractCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var textCommentLabel: UILabel!
    @IBOutlet weak var dateCommentLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var heartImageView: UIImageView!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var heatImageTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var heatImageOptinalTrailingConstraint: NSLayoutConstraint!
    
    
    var profileImageTask: URLSessionDataTask?
    var model: PostOnlyTextCellViewModel?
    weak var delegate: VKReaderAbstractCellDelegate?
    
    func setupUI() {
        contentView.backgroundColor = .white
        profileImageView.layer.cornerRadius = 15
        textCommentLabel.backgroundColor = .gray
    }
    
    func configure(with object: VKReaderViewModelCell) {
        guard let model = object as? PostOnlyTextCellViewModel else { return }
        self.model = model
        self.textCommentLabel.text = model.text
        self.commentCountLabel.text = "\(model.formatNumber(model.commentsCount))"
        self.fullNameLabel.text = ("\(model.profile.firstName ?? "") \(model.profile.lastName ?? "") ")
        self.dateCommentLabel.text = model.formatDate(from: model.dateCreateComment)
        if let countlike = model.item.likes?.count {
            if countlike == 0{
                commentCountLabel.isHidden = true
                heatImageTrailingConstraint.priority = UILayoutPriority(rawValue: 1)
                heatImageOptinalTrailingConstraint.priority = UILayoutPriority(rawValue: 1000)
            } else{
                commentCountLabel.isHidden = false
                heatImageTrailingConstraint.priority = UILayoutPriority(rawValue: 1000)
                heatImageOptinalTrailingConstraint.priority = UILayoutPriority(rawValue: 1)
            }
        }
        if let url = NSURL(string: model.profile.photo50 ?? "") {
            profileImageTask = ImageCache.shared.load(url: url, callback: { [weak self] (image) in
                guard let self = self else { return }
                self.profileImageView.image = image
            })
            profileImageTask?.resume()
        }
        let textHeigth = model.text.height(withConstrainedWidth: UIScreen.main.bounds.width - 20, font: UIFont.systemFont(ofSize: 15))
        self.model?.change(height: textHeigth + 81)
    }
    
    func set(delegate: VKReaderAbstractCellDelegate) {
        self.delegate = delegate
    }
   
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageTask?.cancel()
        profileImageTask = nil
    }

}

