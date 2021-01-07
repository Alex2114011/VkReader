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
    var models: [VKReaderViewModelCell] = []
    var commentService: CommentsService
    var commentsThreadService: CommentsThreadService
    
    var sections: [VKReaderSectionModel] = []
    var postViewModel: VKReaderViewModelCell
    weak var delegate: PostViewDelegate?
    let postIdentifier: Int
    
    init(commentService:CommentsService, postViewModel: VKReaderViewModelCell, postIdentifier: Int, commentsThreadService: CommentsThreadService) {
        self.commentService = commentService
        self.postViewModel = postViewModel
        self.postIdentifier = postIdentifier
        self.commentsThreadService = commentsThreadService
    }
    
    func set(delegate: PostViewDelegate) {
        self.delegate = delegate
    }
    // NEED HELP
    func getComment() {
        commentService.getComments(for: postIdentifier, count: 10, with: 0) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let dto):
                
                guard let profiles = dto.response?.profiles else { return }
                for item in (dto.response?.items ?? []) {
                    let _profile = profiles.first { (prof) -> Bool in
                        return prof.id == item.fromID
                    }
                    if let threadCount = item.thread?.count{
                        if threadCount > 0 {
                            self.getThreadComments(commentID: item.id ?? 0)
                    }
                        if let profile = _profile {
                            self.models.append(VKReaderFactory.makeCommentModel(with: item, and: profile))
                        }
                    }
                }
                let section = VKReaderSection()
                section.cellsViewModel.append(self.postViewModel)
                section.cellsViewModel.append(contentsOf: self.models)
                self.sections = [section]
                self.delegate?.reloadData()
            case .failure(let error):
                print(error?.localizedDescription ?? "")
            }
        }
    }
    
    func nextComment() {
        guard let readerSection = sections.first else { return }
        commentService.getComments(for: postIdentifier, count: 10, with: readerSection.cellsViewModel.count + 1) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let dto):
                var models: [VKReaderViewModelCell] = []
                guard let profiles = dto.response?.profiles else { return }
                for item in dto.response?.items ?? []{
                    let _profile = profiles.first{ (prof) -> Bool in
                        return prof.id == item.fromID
                    }
                    if let profile = _profile {
                        models.append(VKReaderFactory.makeCommentModel(with: item, and: profile))
                }
            }
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
    // NEED HELP
    func getThreadComments(commentID: Int) {
        commentsThreadService.getThreadComments(for: postIdentifier, with: commentID, count: 100, with: 0) { (result)  in
            switch result{
            case .success(let dto):
            guard let profiles = dto.response?.profiles else { return }
                for item in (dto.response?.items ?? []) {
                    let _profile = profiles.first { (prof) -> Bool in
                        return prof.id == item.fromID
                    }
                    if let profile = _profile {
                        self.models.append(VKReaderFactory.makeCommentModel(with: item, and: profile))
                    }
                }
                let section = VKReaderSection()
                section.cellsViewModel.append(contentsOf: self.models)
                self.sections = [section]
                self.delegate?.reloadData()
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
