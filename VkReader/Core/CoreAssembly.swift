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
    lazy var urlProvider = URLProviderImpl()
    lazy var baseNetworkingService = BaseNetworkServiceImpl(hostProvider: hostProvider)
    lazy var wallService: WallService = WallServiceImpl(credentials: credentialsStorage, baseNetworkService: baseNetworkingService, urlProvider: urlProvider)
}

class CorePresentationAssembly {
    
    let coreAssembly: CoreAssembly
    
    init(assembly: CoreAssembly) {
        coreAssembly = assembly
    }
    
    func loginViewController() -> UIViewController {
        let vm = LoginViewModelImpl()
        let vc = LoginViewController(viewModel: vm)
        vc.corePresentation = self
        return vc
    }
    
    func oauthViewController() -> UIViewController {
        let viewModel = OAuthViewModelImpl(credentialsStorage: coreAssembly.credentialsStorage)
        let vc = OAuthWebViewController(viewModel: viewModel)
        vc.corePresentation = self
        return vc
    }
   
    func feedViewController() -> UIViewController {
        let vm = FeedViewModelImpl(service: coreAssembly.wallService)
        let vc = FeedViewController(viewModel: vm)
        let navigationController = UINavigationController(rootViewController: vc)
        vc.corePresentation = self
        navigationController.modalPresentationStyle = .fullScreen
        return navigationController
    }
    
    func swapWindowRoot(to viewController: UIViewController) {
        if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
            
            window.rootViewController = viewController
            window.makeKeyAndVisible()
            UIView.transition(with: window,
                              duration: 0.2,
                              options: .transitionCrossDissolve,
                              animations: nil,
                              completion: nil)
        }
    }
    
}
