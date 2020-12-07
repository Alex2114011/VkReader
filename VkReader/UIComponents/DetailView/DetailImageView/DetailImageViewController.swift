//
//  DetailImageViewController.swift
//  VkReader
//
//  Created by Alex on 07.12.2020.
//

import UIKit

class DetailImageViewController: BaseController,VKReaderAbstractCellDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    weak var delegate: VKReaderAbstractCellDelegate?
    let viewModel: DetailImageViewModel
    
    init(viewmodel: DetailImageViewModel) {
        self.viewModel = viewmodel
        super.init(nibName: String(describing: DetailImageViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didTap(with action: VKReaderTapAction) {
        
    }
    
    func relayout() {
        
    }
    
    func relayout(with completion: (() -> ())?) {
        
    }
    
    func passImage(image: UIImageView) {
        
    }
    

}


