//
//  CollectionAbstracts.swift
//  VkReader
//
//  Created by Alex on 23.11.2020.
//

import UIKit

///Определяем высоту ячейки
enum VKReaderCellHeight {
    case value(CGFloat)
}
/// в протоколе определяем методы для моделей ячеек
protocol VKReaderViewModelCell {
    func cellIdentifier() -> String
    func height() -> VKReaderCellHeight
    func change(height value: CGFloat)
    func heightIsCounted() -> Bool
}
/// делаем расширение так как оно может быть нужно не везде
extension VKReaderViewModelCell {
    func change(height value: CGFloat) {}
}
/// определяем свойства и методы которые должны содержать классы определяющие секции
protocol VKReaderSectionModel {
    var title: String { get set }
    var headerHeight: CGFloat { get }
    var sortRate: Int { get }
    var cellsViewModel: [VKReaderViewModelCell] { get }
    
    func headerIdentifier() -> String
}
///методы для работы с абстрактными ячеками
protocol VKReaderAbstractCell: UICollectionViewCell {
    func setupUI()
    func configure(with object: VKReaderViewModelCell)
    func set(delegate: VKReaderAbstractCellDelegate)
}
/// методы для работы с заголовками
protocol VKReaderAbstractHeader: UICollectionReusableView {
    func setupUI()
    func configure(with object: VKReaderSectionModel)
    func set(delegate: VKReaderAbstractCellDelegate)
}
/// варианты действий при тапе на ячейку
enum VKReaderTapAction {
    
    
}
///методы дял делегирования
protocol VKReaderAbstractCellDelegate: class {
    func didTap(with action: VKReaderTapAction)
    func relayout()
    func relayout(with completion: (() -> ())?)
    func passImage(image: UIImage)
}
