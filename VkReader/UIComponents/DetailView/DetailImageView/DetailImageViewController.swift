//
//  DetailImageViewController.swift
//  VkReader
//
//  Created by Alex on 07.12.2020.
//

import UIKit

class DetailImageViewController: UIViewController{
    
    var image:UIImage
    
    var viewTranslation = CGPoint(x: 0, y: 0)
    
    @IBOutlet weak var imageView: UIImageView!
   
    init(image: UIImage) {
        self.image = image
        super.init(nibName: String(describing: DetailImageViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        setUI()
    }
    
    func setUI(){
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleDismiss(sender:)))
        imageView.addGestureRecognizer(panRecognizer)
        imageView.isUserInteractionEnabled = true
        view.backgroundColor = .darkGray
    }
    
    @objc func handleDismiss(sender: UIPanGestureRecognizer) {
        sender.translation(in: imageView)
        print(sender.translation(in: imageView).y / 100)
        let translation = sender.translation(in: imageView).y / 100
        if translation > 1 {
            view.alpha = 1 - translation
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    
}


