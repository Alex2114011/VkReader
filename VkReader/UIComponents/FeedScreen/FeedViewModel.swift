//
//  FeedScreenViewModel.swift
//  VkReader
//
//  Created by Alex on 17.11.2020.
//

import Foundation

protocol FeedViewDelegate: class {
    func reloadData()
    func update(with indexs: [IndexPath])
}

protocol FeedViewModel {
    var sections: [VKReaderSectionModel] { get }
    
    func set(delegate: FeedViewDelegate)
    func getWall()
    func nextPage()
    var postsId:[Int] {get set}
    var index:Int? {get set}
    func getPostID(indexPath: Int) -> Int
}

class FeedViewModelImpl: FeedViewModel{
    var index: Int?
    var postsId = [Int]()
    
    
    let wallService: WallService
    var commentService: CommentsService
    
    var sections: [VKReaderSectionModel] = []
    weak var delegate: FeedViewDelegate?
    
    init(wallService: WallService, commentService:CommentsService) {
        self.wallService = wallService
        self.commentService = commentService
    }
    
    func set(delegate: FeedViewDelegate) {
        self.delegate = delegate
    }
    
    func getWall() {
        wallService.getPosts(count: 10, with: 0) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let dto):
                print(dto)
                var models: [VKReaderViewModelCell] = []
                guard let group = dto.response?.groups?.first else { return }
                dto.response?.items?.forEach({
                    models.append(VKReaderFactory.makeWallModel(with: $0, and: group))
                })
                let section = VKReaderSection()
                section.cellsViewModel = models
                self.sections = [section]
                self.delegate?.reloadData()
                dto.response?.items?.forEach({ (result) in
                    self.postsId.append(result.id ?? 0)
                    print("!postsId \(self.postsId)")
                })
            case .failure(let error):
                print(error?.localizedDescription ?? "")
            }
        }
    }
    
    func nextPage() {
        guard let readerSection = sections.first else { return }
        wallService.getPosts(count: 10, with: readerSection.cellsViewModel.count + 1) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let dto):
                var models: [VKReaderViewModelCell] = []
                guard let group = dto.response?.groups?.first else { return }
                dto.response?.items?.forEach({
                    models.append(VKReaderFactory.makeWallModel(with: $0, and: group))
                })
                dto.response?.items?.forEach({ (result) in
                    self.postsId.append(result.id ?? 0)
                    print("!postsId \(self.postsId)")
                })
                if let readerSection = self.sections.first as? VKReaderSection {
                    let startIndexPath = IndexPath(row: readerSection.cellsViewModel.count - 1, section: 0)
                    let indexes: [IndexPath] = self.generateIndexPath(count: models.count, from: startIndexPath)
                    readerSection.cellsViewModel.append(contentsOf: models)
                    self.delegate?.update(with: indexes)
                }
            case .failure(let error):
                print(error?.localizedDescription ?? "")
            }
        }
    }
    
    func getPostID(indexPath: Int) -> Int {
        let postID = self.postsId[indexPath]
        commentService.postID = postID
        print("!postsId \(postID)")
        return postID
    }
    
    
    private func generateIndexPath(count: Int, from index: IndexPath) -> [IndexPath] {
        var indexes: [IndexPath] = []
        for i in stride(from: index.row, to: index.row + count, by: 1) {
            indexes.append(IndexPath(row: i, section: index.section))
        }
        return indexes
    }
    
}
