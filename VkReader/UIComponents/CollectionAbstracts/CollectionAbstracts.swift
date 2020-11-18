//
//  CollectionAbstracts.swift
//  VkReader
//
//  Created by p.grechikhin on 18.11.2020.
//

import UIKit

enum VKReaderCellHeight {
    case value(CGFloat)
}

protocol VKReaderViewModelCell {
    func cellIdentifier() -> String
    func height() -> VKReaderCellHeight
    func change(height value: CGFloat)
    func heightIsCounted() -> Bool
}

extension VKReaderViewModelCell {
    func change(height value: CGFloat) {}
}

protocol VKReaderSectionModel {
    var title: String { get set }
    var headerHeight: CGFloat { get }
    var sortRate: Int { get }
    var cellsViewModel: [VKReaderViewModelCell] { get }
    
    func headerIdentifier() -> String
}

protocol VKReaderAbstractCell: UICollectionViewCell {
    func setupUI()
    func configure(with object: VKReaderViewModelCell)
    func set(delegate: VKReaderAbstractCellDelegate)
}

protocol VKReaderAbstractHeader: UICollectionReusableView {
    func setupUI()
    func configure(with object: VKReaderSectionModel)
    func set(delegate: VKReaderAbstractCellDelegate)
}

enum VKReaderTapAction {
    
}

protocol VKReaderAbstractCellDelegate: class {
    func didTap(with action: VKReaderTapAction)
    func relayout()
    func relayout(with completion: (() -> ())?)
}
