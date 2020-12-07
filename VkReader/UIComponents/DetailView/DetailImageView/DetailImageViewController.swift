//
//  DetailImageViewController.swift
//  VkReader
//
//  Created by Alex on 07.12.2020.
//

import UIKit

class DetailImageViewController: BaseController, VKReaderAbstractCellDelegate {
    

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        
    }

    func set(){
        let vc = WallPostWithImageCollectionViewCell()
        vc.delegate = self
    }
    func didTap(with action: VKReaderTapAction) {
        
    }
    
    func relayout() {
        
    }
    
    func relayout(with completion: (() -> ())?) {
        
    }
    
    func passImage(image: UIImage) {
        imageView.image = image
    }
}


