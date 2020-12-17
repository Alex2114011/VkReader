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
    func getCom()
    func nextPage()
}

class FeedViewModelImpl: FeedViewModel{
    
    let service: WallService
    let serviceCom: CommentsService
    
    var sections: [VKReaderSectionModel] = []
    weak var delegate: FeedViewDelegate?
    var arr: [VKReaderSectionModel] = []
    
    init(service: WallService, serviceCom: CommentsService) {
        self.service = service
        self.serviceCom = serviceCom
    }
    
    func set(delegate: FeedViewDelegate) {
        self.delegate = delegate
    }
    
    func getWall() {
        service.getPosts(count: 10, with: 0) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let dto):
                print(dto)
                var models: [VKReaderViewModelCell] = []
                guard let group = dto.response?.groups?.first else { return }
                dto.response?.items?.forEach({
                    models.append(VKReaderFactory.makeModel(with: $0, and: group))
                })
                let section = VKReaderSection()
                section.cellsViewModel = models
                self.sections = [section]
                self.delegate?.reloadData()
            case .failure(let error):
                print(error?.localizedDescription ?? "")
            }
        }
    }
    
    func getCom(){
        print("qwerty")
        serviceCom.getComments(count: 10, with: 0) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let dto):
                print("commentDTO \(dto)")
                var models: [VKReaderViewModelCell] = []
                guard let comment = dto.response?.items?.first else {return}
//                dto.response?.items?.forEach({
//                    models.append(VKReaderFactory.makeModel(with: $0, and: group))
//                })
                let section = VKReaderSection()
                section.cellsViewModel = models
                self.sections = [section]
                self.delegate?.reloadData()
            case .failure(let error):
                print(error?.localizedDescription ?? "")
            }
        }
    }
    
    
    func nextPage() {
        guard let readerSection = sections.first else { return }
        service.getPosts(count: 10, with: readerSection.cellsViewModel.count + 1) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let dto):
                var models: [VKReaderViewModelCell] = []
                guard let group = dto.response?.groups?.first else { return }
                dto.response?.items?.forEach({
                    models.append(VKReaderFactory.makeModel(with: $0, and: group))
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
    
    private func generateIndexPath(count: Int, from index: IndexPath) -> [IndexPath] {
        var indexes: [IndexPath] = []
        for i in stride(from: index.row, to: index.row + count, by: 1) {
            indexes.append(IndexPath(row: i, section: index.section))
        }
        return indexes
    }
    
}
