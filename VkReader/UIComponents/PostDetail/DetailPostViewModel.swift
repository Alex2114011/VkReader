//
//  DetailPostViewModel.swift
//  VkReader
//
//  Created by  Alex on 17.12.2020.
//

import Foundation

protocol DetailPostViewModel {
    
}

class DetailPostViewModelImpl: DetailPostViewModel{
    
    let commentsService: CommentsService

    init(commentsService: CommentsService) {
        self.commentsService = commentsService
    }
    
    func getComments(){
        commentsService.getComments(count: 100, with: 0) { (result) in
            switch result{
            case .success(let dto):
                guard let comments = dto.response?.items else {return}
                print(dto.response?.items)
            case .failure(let error):
                print(error?.localizedDescription ?? "")
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
