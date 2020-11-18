//
//  BaseController.swift
//  VkReader
//
//  Created by p.grechikhin on 13.11.2020.
//

import UIKit
///Основной ViewController от него должны наследоваться все остальные ViewControllerы 
class BaseController: UIViewController {
/// создаем слабую ссылку на класс CorePresentationAssembly нужно это для того, чтобы все созданные VC имели свойства и методы jgb
    weak var corePresentation: CorePresentationAssembly?

}
 
