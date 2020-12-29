//
//  PostDetailViewModel.swift
//  VkReader
//
//  Created by  Alex on 17.12.2020.
//

import Foundation

protocol PostViewDelegate: class {
    func reloadData()
    func update(with indexs: [IndexPath])
}

protocol PostDetailViewModel {
    var sections: [VKReaderSectionModel] { get }
    var index:Int? {get set}
    func set(delegate: PostViewDelegate)
    func getComment()
    func nextComment()
}

class PostDetailViewModelImpl: PostDetailViewModel {
    var index: Int?

    var commentService: CommentsService
    
    var sections: [VKReaderSectionModel] = []
    var postViewModel: VKReaderViewModelCell
    weak var delegate: PostViewDelegate?
    let postIdentifier: Int
    
    init(commentService:CommentsService, postViewModel: VKReaderViewModelCell, postIdentifier: Int) {
        self.commentService = commentService
        self.postViewModel = postViewModel
        self.postIdentifier = postIdentifier
    }
    
    func set(delegate: PostViewDelegate) {
        self.delegate = delegate
    }
    
    func getComment() {
        commentService.getComments(for: postIdentifier, count: 100, with: 0) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let dto):
                print(#function , dto)
                var models: [VKReaderViewModelCell] = []
                guard let profiles = dto.response?.profiles else { return }
                for item in (dto.response?.items ?? []) {
                    let _profile = profiles.first { (prof) -> Bool in
                        return prof.id == item.fromID
                    }
                    if let profile = _profile {
                        models.append(VKReaderFactory.makeCommentModel(with: item, and: profile))
                    }
                }
                let section = VKReaderSection()
                section.cellsViewModel.append(self.postViewModel)
                section.cellsViewModel.append(contentsOf: models)
                self.sections = [section]
                self.delegate?.reloadData()
            case .failure(let error):
                print(error?.localizedDescription ?? "")
            }
        }
    }
    
    func nextComment() {
        guard let readerSection = sections.first else { return }
        commentService.getComments(count: 100, with: readerSection.cellsViewModel.count + 1) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let dto):
                var models: [VKReaderViewModelCell] = []
                guard let profile = dto.response?.profiles?.first else { return }
                dto.response?.items?.forEach({
                    models.append(VKReaderFactory.makeCommentModel(with: $0, and: profile))
                })
//                dto.response?.items?.forEach({ (result) in
//                    self.postsId.append(result.id ?? 0)
//                    print("!postsId \(self.postsId)")
//                })
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
    
    
    
    private func generateIndexPath(count: Int, from index: IndexPath) -> [IndexPath] {
        var indexes: [IndexPath] = []
        for i in stride(from: index.row, to: index.row + count, by: 1) {
            indexes.append(IndexPath(row: i, section: index.section))
        }
        return indexes
    }
    
}


//protocol PostDetailViewModel {
//
//}
//
//class PostDetailViewModelImpl: PostDetailViewModel{
//
//    let commentsService: CommentsService
//
//    init(commentsService: CommentsService) {
//        self.commentsService = commentsService
//    }
//
//    func getComments(){
//        commentsService.getComments(count: 100, with: 0) { (result) in
//            switch result{
//            case .success(let dto):
//                guard let comments = dto.response?.items else {return}
//                print(dto.response?.items)
//            case .failure(let error):
//                print(error?.localizedDescription ?? "")
//            }
//        }
//    }
//
//
//
//
//
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//}