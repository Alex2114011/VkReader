//
//  FeedScreen.swift
//  VkReader
//
//  Created by Alex on 17.11.2020.
//

import UIKit

class FeedScreen: BaseController {
   
    var viewModel: FeedScreenViewModel
    
    init(viewModel: FeedScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: FeedScreen.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

   
    
}
