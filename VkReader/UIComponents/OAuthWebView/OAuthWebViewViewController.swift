//
//  OAuthWebViewViewController.swift
//  VkReader
//
//  Created by p.grechikhin on 13.11.2020.
//

import UIKit
import WebKit

class OAuthWebViewViewController: BaseController {

    var viewModel: OAuthViewModel
    let webView = WKWebView()
    
    init(viewModel: OAuthViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        let url = URL(string: "https://oauth.vk.com/authorize?client_id=6439743&display=page&redirect_uri=https://oauth.vk.com/blank.html&scope=wall&response_type=token&v=5.126")!
        webView.navigationDelegate = self
        webView.load(URLRequest(url: url))
    }

}

extension OAuthWebViewViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if (navigationAction.request.url?.absoluteString.contains("access_token"))! {
            if let token = navigationAction.request.url!.absoluteString.slice(from: "access_token=", to: "&") {
                decisionHandler(.cancel)
                viewModel.saveToken(with: token)
                self.present((corePresentation?.feedViewController())!, animated: true, completion: nil)
                return
            }
        }
        
        decisionHandler(.allow)
    }
}
