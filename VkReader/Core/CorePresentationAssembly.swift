//
//  CorePresentationAssembly.swift
//  VkReader
//
//  Created by Alex on 18.11.2020.
//

import UIKit
/// Данный класс содержит методы для создания ViewController и управлению навигацией в проекте
class CorePresentationAssembly {
    ///Создаем константу типа CoreAssembly
    let coreAssembly: CoreAssembly
    
    /// Создаем инициализатор класса, для того чтобы вызывать методы этого класса через класс CoreAssembly т.е черези инит передаем данные
    init(assembly: CoreAssembly) {
        coreAssembly = assembly
    }
    
    
    /// Используем этот метод для создания VC
    /// В методе создается константа vm содержащая LoginViewModelImpl он нам нужен для того что только через этот класс работатьс моделью
    /// Константа vc содержит в себе сам класс LoginViewController у которого инициализатор требует указать ViewModel с которой он будет взаимодействоать
    /// vc.corePresentation = self передаем в класс baseController ссылку на этот же класс(CorePresentationAssembly) это нужно тогда когда необходимо позволить через этот класс инициализировать ViewController
    /// - Returns: возвращает ViewController
    func loginViewController() -> UIViewController {
        let vm = LoginViewModelImpl()
        let vc = LoginViewController(viewModel: vm)
        vc.corePresentation = self
        return vc
    }
    
    func groupsViewController() -> UIViewController{
        let vm = GroupsViewModelImpl(groupService: coreAssembly.groupsService, accountService: coreAssembly.accountService, wallService: coreAssembly.wallService)
        let vc = GroupsViewController(viewModel: vm)
        let navigationController = UINavigationController(rootViewController: vc)
        vc.corePresentation = self
        navigationController.isNavigationBarHidden = true
//        navigationController.modalPresentationStyle = .fullScreen
        return navigationController
    }
    /// Используем этот метод для создания VC
    /// В методе создается константа vm содержащая LoginViewModelImpl он нам нужен для того что только через этот класс работатьс моделью
    /// Константа vc содержит в себе сам класс LoginViewController у которого инициализатор требует указать ViewModel с которой он будет взаимодействоать
    /// vc.corePresentation = self передаем в класс baseController ссылку на этот же класс(CorePresentationAssembly) это нужно тогда когда необходимо позволить через этот класс инициализировать ViewController
    /// - Returns: возвращает ViewController
    func oauthViewController() -> UIViewController {
        let viewModel = OAuthViewModelImpl(credentialsStorage: coreAssembly.credentialsStorage)
        let vc = OAuthWebViewController(viewModel: viewModel)
        vc.corePresentation = self
        return vc
    }
    /// Используем этот метод для создания VC
    /// В методе создается константа vm содержащая LoginViewModelImpl он нам нужен для того что только через этот класс работатьс моделью
    /// Константа vc содержит в себе сам класс LoginViewController у которого инициализатор требует указать ViewModel с которой он будет взаимодействоать
    /// Так как необходимо дать возможность переходить с этого экрана на другие методом PUSH мы создаем в этом классе свой собственный navigationController который будем использовать при входе в авторизованною зону, а так же указываем стиль открытия модального перехода
    /// vc.corePresentation = self передаем в класс baseController ссылку на этот же класс(CorePresentationAssembly) это нужно тогда когда необходимо позволить через этот класс инициализировать ViewController
    /// - Returns: возвращает ViewController
    func feedViewController(for ownerID: Int) -> UIViewController {
        let vm = FeedViewModelImpl(wallService: coreAssembly.wallService, commentService: coreAssembly.commentsService, for: ownerID)
        let vc = FeedViewController(viewModel: vm)
        vc.corePresentation = self
        return vc
    }
    
    func postDetailViewController(with postModel: VKReaderViewModelCell, for postID: Int, and ownerId:Int) -> UIViewController {
        let vm = PostDetailViewModelImpl(commentService: coreAssembly.commentsService, postViewModel: postModel, postIdentifier: postID, and: ownerId)
        let vc = PostDetailViewController(viewModel: vm)
        vc.corePresentation = self
        return vc
    }
    /// Этот метод позволяет переназначить navigation controller указанный в AppDelegate на другой VC это нужно для первого входа после авторизации пользователя, 
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
