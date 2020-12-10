//
//  DetailImageViewController.swift
//  VkReader
//
//  Created by Alex on 07.12.2020.
//

import UIKit

class DetailImageViewController: UIViewController{
    
    var image:UIImage
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewYConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewXConstraint: NSLayoutConstraint!
    
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
        view.backgroundColor = .black
        var height = image.size.height
        var width = image.size.width
        if height > UIScreen.main.bounds.height - 100{
            height = UIScreen.main.bounds.height
            print("высота \(height)")
        }
        if width > UIScreen.main.bounds.width{
            width = UIScreen.main.bounds.width
            print("ширина \(width)")
        }
        imageViewHeightConstraint.constant = height
        imageViewWidthConstraint.constant = width
    }
    
    @objc func handleDismiss(sender: UIPanGestureRecognizer) {
        sender.translation(in: imageView)
        let translationY = sender.translation(in: imageView).y
        let translationX = sender.translation(in: imageView).x
        imageViewYConstraint.constant = translationY
        imageViewXConstraint.constant = translationX
        view.alpha = 1 - (abs(translationY) + abs(translationX)) / 600
        print("abs(translationX)\(abs(translationX)),   view.alpha\(view.alpha)")
        if imageViewYConstraint.constant > 300 || imageViewYConstraint.constant < -300 ||
            imageViewXConstraint.constant  > 300 || imageViewXConstraint.constant  < -300 {
            self.dismiss(animated: false, completion: nil)
        }
        if sender.state == .ended{
            view.alpha = 1
            imageViewYConstraint.constant = 0
            imageViewXConstraint.constant = 0
        }
    }
    
}


