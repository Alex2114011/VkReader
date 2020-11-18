    //
    //  FeedViewController.swift
    //  VkReader
    //
    //  Created by Alex on 17.11.2020.
    //

    import UIKit

    class FeedViewController: BaseController {

    var collectionView = UICollectionView()

    var viewModel: FeedViewModel

    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: FeedViewController.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        collectionView.register(UINib(nibName: String(describing: FeedCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: FeedCollectionViewCell.self))

    }

    func setUI(){
        let view = UIView()
        view.backgroundColor = .white
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)
        
        collectionView.backgroundColor = UIColor.white
        
        collectionView.dataSource = self
        collectionView.delegate = self
 
        view.addSubview(collectionView)
        
        self.view = view
    }
}
    

    extension FeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:String(describing: FeedCollectionViewCell.self), for: indexPath) as? FeedCollectionViewCell else { fatalError()}
        cell.backgroundColor = UIColor.lightGray
        return cell
    }
    }
    extension FeedViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       print("User tapped on item \(indexPath.row)")
    }
    }

