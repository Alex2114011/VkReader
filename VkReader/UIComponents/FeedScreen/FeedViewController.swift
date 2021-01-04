    //
    //  FeedViewController.swift
    //  VkReader
    //
    //  Created by Alex on 17.11.2020.
    //

    import UIKit
/// View Controller в нем происходит работа с  интерфейсом, можно сказать что это обратная сторона view которое видит пользователь
class FeedViewController: BaseController {
   
    var viewModel: FeedViewModel
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: FeedViewController.self), bundle: nil)
        self.viewModel.set(delegate: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.getWall()
//        viewModel.getComment()
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
    }
    
}

extension FeedViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
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

extension FeedViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row - 2 >= viewModel.sections[indexPath.section].cellsViewModel.count - 3 {
            viewModel.nextPage()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.index = indexPath.row
        let viewModelCell = viewModel.sections[indexPath.section].cellsViewModel[indexPath.row]
        guard let core = corePresentation else { return }
        self.present(core.postDetailViewController(with: viewModelCell, for: viewModel.getPostID(indexPath: indexPath.row)), animated: true, completion: nil)
        
    }
}

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = viewModel.sections[indexPath.section].cellsViewModel[indexPath.row].height()
        switch item {
        case .value(let value):
            return CGSize(width: view.bounds.width, height: value)
        }
    }
}

extension FeedViewController: VKReaderAbstractCellDelegate {
    func passImage(image: UIImage) {
        let vc = DetailImageViewController(image: image)
        vc.modalPresentationStyle = .custom
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
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

extension FeedViewController: FeedViewDelegate {
    func reloadData() {
        collectionView.reloadData()
    }
    
    func update(with indexs: [IndexPath]) {
        collectionView.performBatchUpdates({
            collectionView.insertItems(at: indexs)
        }, completion: nil)
    }
    
}
