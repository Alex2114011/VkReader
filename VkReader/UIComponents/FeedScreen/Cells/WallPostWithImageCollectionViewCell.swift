//
//  WallPostWithImageCollectionViewCell.swift
//  VkReader
//
//  Created by Alex on 19.11.2020.
//

import UIKit

class WallPostWithImageCollectionViewCell: UICollectionViewCell, VKReaderAbstractCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var groupImageView: UIImageView!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var groupNameLabel: UILabel!
    /// Создаем оутлет на констрейнт это нужно для того чтобы сделать динимическую высоту view
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var heartImageView: UIImageView!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var commentsImageView: UIImageView!
    @IBOutlet weak var commentsCountLabel: UILabel!
    @IBOutlet weak var viewsImageView: UIImageView!
    @IBOutlet weak var viewsCountLabel: UILabel!
    

    var model: WallPostWithImageCellViewModel?
    weak var delegate: VKReaderAbstractCellDelegate?
    var imageTask: URLSessionDataTask?
    var groupImageTask: URLSessionDataTask?
    
    func setupUI() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(presentImage(sender:)))
        imageView.addGestureRecognizer(tapRecognizer)
        imageView.isUserInteractionEnabled = true
        contentView.backgroundColor = .white
        groupImageView.layer.cornerRadius = 15
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        let paragraphStyle = NSMutableParagraphStyle()
        let font = UIFont.systemFont(ofSize: 15)
        paragraphStyle.lineSpacing = 1.12
        let attributedString = NSAttributedString(string: model?.text ?? "", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle , NSAttributedString.Key.font: font])
        postLabel.attributedText = attributedString
    }
    
    func configure(with object: VKReaderViewModelCell) {
        guard let model = object as? WallPostWithImageCellViewModel else { return }
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
        guard let url = NSURL(string: model.imageURLString) else { return }
        imageTask = ImageCache.shared.load(url: url) { [weak self] (image) in
            guard let self = self else { return }
            self.imageView.image = image
        }
        imageTask?.resume()
        let textHeigth = model.text.height(withConstrainedWidth: UIScreen.main.bounds.width - 20, font: UIFont.systemFont(ofSize: 15))
        self.model?.change(height: textHeigth + 105 + model.imageHeigth)
        imageWidthConstraint.constant = model.imageWidth
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

    @objc func presentImage(sender: UITapGestureRecognizer){
        guard let image = imageView.image else {return}
        self.delegate?.passImage(image: image)

    }
}

