//
//  OAuthViewModel.swift
//  VkReader
//
//  Created by p.grechikhin on 13.11.2020.
//

import Foundation

protocol OAuthViewModel {
    func saveToken(with token: String)
}

class OAuthViewModelImpl: OAuthViewModel {
    
    let credentialsStorage: CredentialsStorage
    
    init(credentialsStorage: CredentialsStorage) {
        self.credentialsStorage = credentialsStorage
    }
    
    func saveToken(with token: String) {
        credentialsStorage.save(key: kToken, value: token)
        print(credentialsStorage.get(key: kToken))
    }
    
    
}
