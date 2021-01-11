//
//  GroupsViewController.swift
//  VkReader
//
//  Created by Alex on 10.01.2021.
//

import UIKit

class GroupsViewController: BaseController {

    var viewModel: GroupsViewModel
    let userCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 5
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    init(viewModel: GroupsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: GroupsViewController.self), bundle: nil)
        self.viewModel.set(delegate: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getGroups()
        viewModel.getAccount()
        setupUI()
    }

    func  setupUI() {
        view.addSubview(userCollectionView)
        userCollectionView.backgroundColor = UIColor(red: 1/230, green: 1/233, blue: 1/237, alpha: 0.07)
        userCollectionView.translatesAutoresizingMaskIntoConstraints = false
        userCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        userCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        userCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        userCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        userCollectionView.dataSource = self
        userCollectionView.delegate = self
        registerCells()
    }
    
    func registerCells(){
        userCollectionView.register(UINib(nibName: String(describing: UserGroupsCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: UserGroupsCollectionViewCell.self))
    }
}

extension GroupsViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.sections[section].cellsViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = viewModel.sections[indexPath.section].cellsViewModel[indexPath.row]
        let cell = userCollectionView.dequeueReusableCell(withReuseIdentifier: item.cellIdentifier(), for: indexPath) as! VKReaderAbstractCell
        cell.setupUI()
        cell.set(delegate: self)
        cell.configure(with: item)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
}

extension GroupsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = viewModel.sections[indexPath.section].cellsViewModel[indexPath.row].height()
        switch item {
        case .value(let value):
            return CGSize(width: view.bounds.width, height: value)
        }
    }
}

extension GroupsViewController: VKReaderAbstractCellDelegate {
    func didTap(with action: VKReaderTapAction) {
        
    }
    
    func relayout() {
        userCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    func relayout(with completion: (() -> ())?) {
        userCollectionView.performBatchUpdates({
            userCollectionView.collectionViewLayout.invalidateLayout()
        }) { (_) in
            completion?()
        }
    }
    
    func passImage(image: UIImage) {
        
    }
    

    }

extension GroupsViewController: GroupsViewDelegate {
    func update(with indexs: [IndexPath]) {
        userCollectionView.performBatchUpdates({
            userCollectionView.insertItems(at: indexs)
        }, completion: nil)
    }
    
    func reloadData() {
        userCollectionView.reloadData()
    }
}
