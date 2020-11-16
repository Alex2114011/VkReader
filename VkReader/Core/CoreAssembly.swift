//
//  CoreAssembly.swift
//  VkReader
//
//  Created by p.grechikhin on 13.11.2020.
//

import UIKit

class CoreAssembly {
    
    lazy var presentationAssembly: CorePresentationAssembly = CorePresentationAssembly(assembly: self)
    
    lazy var credentialsStorage = CredentialsStorage()
    lazy var hostProvider = HostProviderImpl()
    lazy var baseNetworkingService = BaseNetworkServiceImpl(hostProvider: hostProvider)
}

class CorePresentationAssembly {
    
    let coreAssembly: CoreAssembly
    
    init(assembly: CoreAssembly) {
        coreAssembly = assembly
    }
    
    func loginViewController() -> UIViewController {
        let vm = LoginScreenImpl()
        let vc = LoginScreen(viewModel: vm)
        vc.corePresentation = self
        return vc
    }
    
    func oauthViewController() -> UIViewController {
        let viewModel = OAuthViewModelImpl(credentialsStorage: coreAssembly.credentialsStorage)
        let vc = OAuthWebViewViewController(viewModel: viewModel)
        vc.corePresentation = self
        return vc
    }
    
}
