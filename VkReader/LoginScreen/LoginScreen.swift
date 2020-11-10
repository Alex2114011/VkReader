//
//  LoginScreen.swift
//  VkReader
//
//  Created by  Alex on 10.11.2020.
//

import UIKit

class LoginScreen: UIViewController {
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var loginTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var eyeIcon: UIButton!
    @IBOutlet weak var LoginButton: UIButton!
    var eyeButtonActive = false
    
//    var viewModel: LoginScreenViewModel
    
//    init(viewModel: LoginScreenViewModel) {
//        self.viewModel = viewModel
//        super.init(nibName: String(describing: LoginScreenViewModel.self), bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
setUI()
     
    }

    
    func setUI(){

        self.view.backgroundColor = .white
        loginView.layer.cornerRadius = 10
        loginView.backgroundColor = #colorLiteral(red: 0.9450133443, green: 0.9529947639, blue: 0.9606699347, alpha: 1)
        navigationController?.navigationBar.isHidden = true
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = #colorLiteral(red: 0.8901158571, green: 0.8980898261, blue: 0.9057741761, alpha: 1).cgColor
        border.frame = CGRect(x: 0, y: loginTF.frame.size.height - width, width: loginTF.frame.size.width, height: loginTF.frame.size.height)
        border.borderWidth = width
        loginTF.backgroundColor = UIColor.clear
        loginTF.layer.addSublayer(border)
        loginTF.layer.masksToBounds = true
        loginTF.textColor = #colorLiteral(red: 0.5215188861, green: 0.5294433236, blue: 0.552872479, alpha: 1)
        loginTF.placeholder = "Email или Телефон"
        loginTF.clearButtonMode = .whileEditing
        passwordTF.isSecureTextEntry = true
        passwordTF.placeholder = "Пароль"
        eyeIcon.setImage(UIImage(systemName: "eye"), for: .normal)
        switchIcon()
        LoginButton.tintColor = .white
        LoginButton.backgroundColor = #colorLiteral(red: 0.7175578475, green: 0.8078915477, blue: 0.9175351858, alpha: 1)
        LoginButton.layer.cornerRadius = 10
    }
    

    func switchIcon(){
        eyeIcon.addTarget(self, action: #selector(switchIconState(parameter:)), for: .touchUpInside)
        
    }
    @objc func switchIconState(parameter: UIButton!){
        if eyeButtonActive{
        eyeIcon.setImage(UIImage(systemName:"eye"), for: .normal)
            eyeButtonActive = !eyeButtonActive
            passwordTF.isSecureTextEntry = true
        }else{
            passwordTF.isSecureTextEntry = false
            eyeIcon.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            eyeButtonActive = !eyeButtonActive
        }
    }
//    func loginButtonActive(){
//        if loginTF.text?.isEmpty
//    }

}
