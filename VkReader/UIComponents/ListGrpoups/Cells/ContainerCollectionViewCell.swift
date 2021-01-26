//
//  ContainerCollectionViewCell.swift
//  VkReader
//
//  Created by Alex on 15.01.2021.
//

import UIKit
// внутряння коллекция
class ContainerCollectionViewCell: UICollectionViewCell, VKReaderAbstractCell {
    
    var model:[ContainerCollectionViewCellModel]?
    weak var delegate: VKReaderAbstractCellDelegate?
    var modelForCell: VKReaderViewModelCell?
    
    
    
    let collectionView:UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 3
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    func setupUI() {
        
        addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: 8).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionView.delegate = self
        collectionView.dataSource = self
        registerCell()
       
    }
    
    func configure(with object: VKReaderViewModelCell) {
        guard let model = object as? ContainerArrayWrapperCellViewModel else {return}
        self.model = model.items
        collectionView.reloadData()
    }
    
    func set(delegate: VKReaderAbstractCellDelegate) {
        self.delegate = delegate
    }
    
    func registerCell() {
        collectionView.register(UINib(nibName: String(describing: UserGroupsCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier:  String(describing: UserGroupsCollectionViewCell.self))
    }
    
}

extension ContainerCollectionViewCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = model else { fatalError() }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: UserGroupsCollectionViewCell.self), for: indexPath) as! VKReaderAbstractCell
        cell.setupUI()
        cell.configure(with: item[indexPath.row])
        return cell
    }
    
}


extension ContainerCollectionViewCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 105)
    }
}
