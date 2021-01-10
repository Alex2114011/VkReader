//
//  CoreAssembly.swift
//  VkReader
//
//  Created by p.grechikhin on 13.11.2020.
//

import UIKit
///Описание класса
/// Этот класс нам нужен для того чтобы собрать необходимые методы с других классов в одном, проще запомнить один класс который отвечает за большинство методов в проекте, чем каждый раз обращаться к разным классам. Получается единая точка входа. Свойства класса реализованы как ленивые, что позволяет не забивать память, так как ленивые свойства загружаются только после первого обращения к ним, а так же есть вероятность не получить значение до конца инициализации, что могло бы приводить к ошибке.
class CoreAssembly {
    /// Создаем переменную для доступа к CorePresentationAssembly в его инициализаторе указываем ссылку на класс CoreAssembly т.е на себя же, так как из  класса CoreAssembly будем инициалировать CorePresentationAssembly
    lazy var presentationAssembly: CorePresentationAssembly = CorePresentationAssembly(assembly: self)
    /// Экземпляр класса в котором реализованны  методы хранения Keychain
    lazy var credentialsStorage = CredentialsStorage()
    /// Экземпляр класса HostProviderImpl в котором реализуем метод который будет нам возвращать в зависимости от кейса URL API
    lazy var hostProvider = HostProviderImpl()
    lazy var urlProvider = URLProviderImpl()
    /// Экземпляр класса BaseNetworkServiceImpl в котором реализован метод отправки сетевого запроса
    lazy var baseNetworkingService = BaseNetworkServiceImpl(hostProvider: hostProvider)
    lazy var wallService: WallService = WallServiceImpl(credentials: credentialsStorage, baseNetworkService: baseNetworkingService, urlProvider: urlProvider)
    
    lazy var commentsService: CommentsService = CommentsServiceImpl(credentials: credentialsStorage, baseNetworkService: baseNetworkingService, urlProvider: urlProvider)
    
    lazy var commetnsThreatService: CommentsThreadService = CommentsThreadServiceImpl(credentials: credentialsStorage, baseNetworkService: baseNetworkingService, urlProvider: urlProvider)
    
    lazy var accountService: AccountService = AccountServiceImpl(credentials: credentialsStorage, baseNetworkService: baseNetworkingService, urlProvider: urlProvider)
}

