//
//  LoginViewController.swift
//  VkReader
//
//  Created by Alex on 17.11.2020.
//

import UIKit

class LoginViewController: BaseController {
    
    @IBOutlet weak var authorizationButton: UIButton!
    var viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: LoginViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupUI()
    }
    func setupUI(){
        authorizationButton.layer.cornerRadius = 6
        authorizationButton.backgroundColor = #colorLiteral(red: 0.2861515284, green: 0.5255295634, blue: 0.7998994589, alpha: 1)
    }
    
    @IBAction func goToAuthorization(_ sender: UIButton) {
        guard let core = corePresentation else { return }
        self.present(core.oauthViewController(), animated: true, completion: nil)
    }
    
        
}
