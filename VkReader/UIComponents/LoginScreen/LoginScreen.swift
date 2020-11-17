//
//  LoginScreen.swift
//  VkReader
//
//  Created by  Alex on 10.11.2020.
//

import UIKit

class LoginScreen: BaseController {

    
    var viewModel: LoginScreenViewModel
    
    init(viewModel: LoginScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: LoginScreen.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func goToAuthorization(_ sender: UIButton) {
        guard let core = corePresentation else { return }
        self.present(core.oauthViewController(), animated: true, completion: nil)
    }
}
