//
//  FeedViewController.swift
//  VkReader
//
//  Created by Alex on 17.11.2020.
//

import UIKit

class FeedViewController: BaseController {
   
    var viewModel: FeedViewModel
    
    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: FeedViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

   
    
}
