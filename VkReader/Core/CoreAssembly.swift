//
//  CoreAssembly.swift
//  VkReader
//
//  Created by p.grechikhin on 13.11.2020.
//

import UIKit

class CoreAssembly {
    /// создаем ленивое свойство с типом данных CorePresentationAssembly и инициализируем в него экземпляр клсасса CorePresentationAssembly с инициализатором,
    lazy var presentationAssembly: CorePresentationAssembly = CorePresentationAssembly(assembly: self)
    /// экземпляр класса CredentialsStorage для доступа к методам этого класса
    lazy var credentialsStorage = CredentialsStorage()
    /// модель класса
    lazy var hostProvider = HostProviderImpl()
    /// тоже модель 
    lazy var baseNetworkingService = BaseNetworkServiceImpl(hostProvider: hostProvider)
}
///
class CorePresentationAssembly {
    ///Создаем константу типа CoreAssembly
    let coreAssembly: CoreAssembly
    
    /// Создаем инициализатор класса, для того чтобы вызывать методы этого класса через класс CoreAssembly
    /// - Parameter assembly: передаем константе coreAssembly экземпляр класса CoreAssembly
    init(assembly: CoreAssembly) {
        coreAssembly = assembly
    }
    
    /// Этот метод возвращает ViewController, если нужно использовать где то в проекте данный viewController, то инициализируем его только отсюда
    /// - let vm : создаем константу класса ViewModelImpl() это нужно для того чтобы у созданного viewController был доступ к свойствам класса ViewModelImpl()
    /// - let vс :  создаем константу класса LoginViewController с его инициализатором
    /// - vc.corePresentation = self :  назначаем делегатом класс CorePresentationAssembly это нужно для того что бы  произошла инициализация класса, ТУТ Я НЕ УВЕРЕН.
    /// - Returns: возвращает  viewController
    func loginViewController() -> UIViewController {
        let vm = LoginViewModelImpl()
        let vc = LoginViewController(viewModel: vm)
        vc.corePresentation = self
        return vc
    }
    /// Этот метод возвращает ViewController, если нужно использовать где то в проекте данный viewController, то инициализируем его только отсюда
    /// - let viewModel: создаем константу класса ViewModelImpl() это нужно для того чтобы у созданного viewController был доступ к свойствам класса ViewModelImpl()
    /// - let vс :  создаем константу класса OAuthWebViewController с его инициализатором
    /// - vc.corePresentation = self :  назначаем делегатом класс CorePresentationAssembly это нужно для того что бы  произошла инициализация класса, ТУТ Я НЕ УВЕРЕН.
    /// - Returns: возвращает  viewController
    func oauthViewController() -> UIViewController {
        let viewModel = OAuthViewModelImpl(credentialsStorage: coreAssembly.credentialsStorage)
        let vc = OAuthWebViewController(viewModel: viewModel)
        vc.corePresentation = self
        return vc
    }
    /// Этот метод возвращает ViewController, если нужно использовать где то в проекте данный viewController, то инициализируем его только отсюда
    /// - let viewModel: создаем константу класса ViewModelImpl() это нужно для того чтобы у созданного viewController был доступ к свойствам класса ViewModelImpl()
    /// - let vс :  создаем константу класса OAuthWebViewController с его инициализатором
    /// - let navigationController: Создаем собственный для класса navigationController и указываем его же корневым VC это нужно для того чтобы осуществлять с него переходы на другие view
    /// - vc.corePresentation = self :  назначаем делегатом класс CorePresentationAssembly это нужно для того что бы  произошла инициализация класса, ТУТ Я НЕ УВЕРЕН.
    /// - navigationController.modalPresentationStyle: Определям вариант стиля перехода на другой view
    /// - Returns: возвращает  navigationController
    func feedViewController() -> UIViewController {
        let vm = FeedViewModelImpl()
        let vc = FeedViewController(viewModel: vm)
        let navigationController = UINavigationController(rootViewController: vc)
        vc.corePresentation = self
        navigationController.modalPresentationStyle = .fullScreen
        return  navigationController
    }
    /// Этот метод позволяет переназначить navigation controller указанный в AppDelegate на другой VC
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
