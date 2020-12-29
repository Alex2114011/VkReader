//
//  PostDetailViewController.swift
//  VkReader
//
//  Created by Alex on 27.12.2020.
//

import UIKit

class PostDetailViewController: BaseController {
    
    var viewModel:PostDetailViewModel
    
    let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    init(viewModel: PostDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: PostDetailViewController.self), bundle: nil)
        self.viewModel.set(delegate: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("поломалось тут")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getComment()
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = UIColor(red: 1/230, green: 1/233, blue: 1/237, alpha: 0.07)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        registerCells()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func registerCells() {
        collectionView.register(UINib(nibName: String(describing: WallPostOnlyTextCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: WallPostOnlyTextCollectionViewCell.self))
        collectionView.register(UINib(nibName: String(describing: WallPostWithImageCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: WallPostWithImageCollectionViewCell.self))
        collectionView.register(UINib(nibName: String(describing: PostOnlyTextCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: PostOnlyTextCollectionViewCell.self))
        collectionView.register(UINib(nibName: String(describing: PostWithImageCollectionViewCell.self), bundle: nil),forCellWithReuseIdentifier: String(describing: PostWithImageCollectionViewCell.self))
    }
}

extension PostDetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        print("количество секций  \(viewModel.sections.count)")
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.sections[section].cellsViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = viewModel.sections[indexPath.section].cellsViewModel[indexPath.row]
        print("Какая ячейка будет выбрана \(item)")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.cellIdentifier(), for: indexPath) as! VKReaderAbstractCell
        cell.setupUI()
        cell.set(delegate: self)
        cell.configure(with: item)
        return cell
    }
}

extension PostDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row - 2 >= viewModel.sections[indexPath.section].cellsViewModel.count - 3 {
            viewModel.nextComment()
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.index = indexPath.row
    }
}

extension PostDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = viewModel.sections[indexPath.section].cellsViewModel[indexPath.row].height()
        switch item {
        case .value(let value):
            return CGSize(width: view.bounds.width, height: value)
        }
    }
}

extension PostDetailViewController: VKReaderAbstractCellDelegate {
    func passImage(image: UIImage) {
//        let vc = DetailImageViewController(image: image)
//        print(image)
//        vc.modalPresentationStyle = .custom
//        vc.modalTransitionStyle = .crossDissolve
//        self.present(vc, animated: true, completion: nil)
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
    
    func didTap(with action: VKReaderTapAction) {
    }
}

extension PostDetailViewController: PostViewDelegate {
    func reloadData() {
        collectionView.reloadData()
    }
    
    func update(with indexs: [IndexPath]) {
        collectionView.performBatchUpdates({
            collectionView.insertItems(at: indexs)
        }, completion: nil)
    }
    
}

