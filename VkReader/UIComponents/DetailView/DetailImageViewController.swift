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
    private var panGestureAnchorPoint: CGPoint?
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
        imageView.isUserInteractionEnabled = true
        view.backgroundColor = .black
        sizesImageView()
        recognizers()
    }
    
    func sizesImageView(){
        var height = image.size.height
        var width = image.size.width
        if height > UIScreen.main.bounds.height - 100{
            height = UIScreen.main.bounds.height
        }
        if width > UIScreen.main.bounds.width{
            width = UIScreen.main.bounds.width
        }
        imageViewHeightConstraint.constant = height
        imageViewWidthConstraint.constant = width
    }
 
    
    func recognizers(){
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleDismiss(sender:)))
        let pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinchForZoom(sender:)))
        imageView.addGestureRecognizer(panRecognizer)
        imageView.addGestureRecognizer(pinchRecognizer)
    }
    
    @objc func handleDismiss(sender: UIPanGestureRecognizer) {
        if sender.state == .began{
            panGestureAnchorPoint = sender.translation(in: imageView)
        }
        if sender.state == .changed{
        guard let panGestureAnchorPoint = panGestureAnchorPoint else { fatalError("nil")}

        let gesturePoint = sender.translation(in: imageView)

        imageViewYConstraint.constant += gesturePoint.y - panGestureAnchorPoint.y
        imageViewXConstraint.constant += gesturePoint.x - panGestureAnchorPoint.x
            view.alpha = 1 - (abs(gesturePoint.y) + abs(gesturePoint.x)) / 300
        self.panGestureAnchorPoint = gesturePoint
//            if imageViewYConstraint.constant > 300 || imageViewYConstraint.constant < -300 ||
//                imageViewXConstraint.constant  > 300 || imageViewXConstraint.constant  < -300 {
//            }
        }
        if sender.state == .ended{
            self.dismiss(animated: false, completion: nil)
            view.alpha = 1
//            imageViewYConstraint.constant = 0
//            imageViewXConstraint.constant = 0
            
        }
    }
    @objc func pinchForZoom(sender: UIPinchGestureRecognizer) {
            let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
            guard let scale = scaleResult, scale.a > 1, scale.d > 1  else {return}
            sender.view?.transform = scale
            sender.scale = 1
        }
}
