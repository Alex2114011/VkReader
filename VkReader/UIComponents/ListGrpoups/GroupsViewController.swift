//
//  GroupsViewController.swift
//  VkReader
//
//  Created by Alex on 10.01.2021.
//

import UIKit

class GroupsViewController: BaseController {

    var viewModel: GroupsViewModel
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
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
        viewModel.getAccount()
        viewModel.getGroupsCatalog()
        setupUI()
    }

    func  setupUI() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.dataSource = self
        collectionView.delegate = self
        registerCells()
    }
    
    func registerCells(){
        collectionView.register(UINib(nibName: String(describing: ContainerCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: ContainerCollectionViewCell.self))
        collectionView.register(UINib(nibName: String(describing: CatalogGroupsCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: CatalogGroupsCollectionViewCell.self))
        collectionView.register(HeaderCatalogCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: HeaderCatalogCollectionReusableView.self))
        collectionView.register(FooterCatalogCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: String(describing: FooterCatalogCollectionReusableView.self))
    }
}

extension GroupsViewController: UICollectionViewDataSource{
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.index = indexPath.row
        guard let core = corePresentation else { return }
        self.navigationController?.pushViewController(core.feedViewController(for: viewModel.getOwnerID(indexPath: indexPath.row)), animated: true)
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
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0{
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: HeaderCatalogCollectionReusableView.self), for: indexPath) as! HeaderCatalogCollectionReusableView
        header.configure()
        return header
        } else if indexPath.section == 1{
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: String(describing: FooterCatalogCollectionReusableView.self), for: indexPath) as! FooterCatalogCollectionReusableView
            footer.configure()
            return footer
        }
        assert(false, "No have SupplementaryElementOfKind for sectionSupplementaryElementOfKind")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 30)
    }
}

extension GroupsViewController: VKReaderAbstractCellDelegate {
    func passOwnerID(with ownerID: Int) {
        guard let core = corePresentation else { return  }
        self.present(core.feedViewController(for: ownerID), animated: true, completion: nil)
    }
    
    
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

extension GroupsViewController: GroupsViewDelegate {
    func update(with indexs: [IndexPath]) {
        collectionView.performBatchUpdates({
            collectionView.insertItems(at: indexs)
        }, completion: nil)
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
}
