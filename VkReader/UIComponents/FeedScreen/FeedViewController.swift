    //
    //  FeedViewController.swift
    //  VkReader
    //
    //  Created by Alex on 17.11.2020.
    //

    import UIKit
/// View Controller в нем происходит работа с  интерфейсом, можно сказать что это обратная сторона view которое видит пользователь
class FeedViewController: BaseController {
/// создаем экземпляр класса методом вычисляемого свойства, фактически при загрузке экране будет происходить назначение в константу collectionView ее свойст
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    ///
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
    }
    
/// Метод который ответственнен за настройку пользовательских UI элементов
    func setUI(){
        /// используем view которым управляет контроллер и добавляем в него созданный ранее collectionView
        view.addSubview(collectionView)
        collectionView.backgroundColor = UIColor(red: 230, green: 233, blue: 237, alpha: 0.07)
        ///указываем  не создавать ограничения Auto Layout автоматически
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        ///Добавляем свои констрейнты
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        /// подписываемся под протоколы CollectionView это нужно для того чтобы получить дополнительные методы в этих протоколах
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    func registerCells() {
        collectionView.register(UINib(nibName: String(describing: WallPostOnlyTextCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: WallPostOnlyTextCollectionViewCell.self))
        collectionView.register(UINib(nibName: String(describing: WallPostWithImageCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: WallPostWithImageCollectionViewCell.self))
    }
}
    
    
//MARK: Delegate CollectionView
    extension FeedViewController: UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 1
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            return 
        }
        

}
    
extension FeedViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("User tapped on item \(indexPath.row)")
    }
}

extension FeedViewController: UICollectionViewDelegateFlowLayout{
    
}

