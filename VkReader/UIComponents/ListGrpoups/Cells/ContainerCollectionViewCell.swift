//
//  ContainerCollectionViewCell.swift
//  VkReader
//
//  Created by Alex on 15.01.2021.
//

import UIKit

class ContainerCollectionViewCell: UICollectionViewCell, ContainerCollectionViewCellModel {
    var viewModel: GroupsViewModel

    init(viewModel: GroupsViewModel) {
        super.init(nibName: String(describing: UserGroupsCollectionViewCell.self), bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let collectionView:UICollectionView = {
        let layuot = UICollectionViewFlowLayout()
        layuot.scrollDirection = .horizontal
        layuot.minimumLineSpacing = 5
        let view = UICollectionView(frame: .zero, collectionViewLayout: layuot)
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupIU()
        registerCells()
    }
    
    func setupIU(){
        addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
    }
    
    func registerCells(){
        collectionView.register(UINib(nibName: String(describing: UserGroupsCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: UserGroupsCollectionViewCell.self))
    }

}

extension ContainerCollectionViewCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.sections[section].cellsViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = viewModel.sections[indexPath.section].cellsViewModel[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.cellIdentifier(), for: indexPath) as! VKReaderAbstractCell
        cell.setupUI()
        cell.set(delegate: self)
        cell.configure(with: item)
        return cell
    }
    
    
}


extension ContainerCollectionViewCell:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = viewModel.sections[indexPath.section].cellsViewModel[indexPath.row].height()
        switch item {
        case .value(let value):
            return CGSize(width: bounds.width, height: value)
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: HeaderCatalogCollectionReusableView.self), for: indexPath) as! HeaderCatalogCollectionReusableView
        header.configure()
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: frame.size.width, height: 50)
    }
}

extension ContainerCollectionViewCell: VKReaderAbstractCellDelegate {
    func didTap(with action: VKReaderTapAction) {
        
    }
    
    func relayout() {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func relayout(with completion: (() -> ())?) {
        collectionView.performBatchUpdates({
            collectionView.collectionViewLayout.invalidateLayout()
        }) { (_) in
            completion?()
        }
    }
    
    func passImage(image: UIImage) {
        
    }
    
    
}
