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
    
    let panGestureRecognizer = UIPanGestureRecognizer()
    var panGestureAnchorPoint: CGPoint?
    let pinchGestureRecognizer = UIPinchGestureRecognizer()
    var pinchGestureAnchorScale: CGFloat?
    
    var scale: CGFloat = 1.0
    
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
//        setUI()
        setupGestureRecognizers()
    }
    
    func setupGestureRecognizers() {
        panGestureRecognizer.addTarget(self, action: #selector(handlePanGesture(_:)))
        pinchGestureRecognizer.addTarget(self, action: #selector(handlePinchGesture(_:)))
        imageView.addGestureRecognizer(panGestureRecognizer)
    }

    
    @objc func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer){
//        print(gestureRecognizer.state)
        switch gestureRecognizer.state {
        case .began:
            panGestureAnchorPoint = gestureRecognizer.location(in: imageView)
//            print(panGestureAnchorPoint)
        case .changed:
            guard let panGestureAnchorPoint = panGestureAnchorPoint else { return }
            let gesturePoint = gestureRecognizer.location(in: imageView)
            
            imageViewXConstraint.constant += gesturePoint.x - panGestureAnchorPoint.x
            imageViewYConstraint.constant += gesturePoint.y - panGestureAnchorPoint.y
//            self.panGestureAnchorPoint = gesturePoint
            
        case .cancelled, .ended:
        panGestureAnchorPoint = nil
        case .failed, .possible:
        panGestureAnchorPoint = nil
            break
        }
    }
    
    @objc func handlePinchGesture(_ gestureRecognizer: UIPinchGestureRecognizer){
        switch gestureRecognizer.state {
        case .began:
            pinchGestureAnchorScale = gestureRecognizer.scale
        case .changed:
        guard let pinchGestureAnchorScale = pinchGestureAnchorScale else { return }
        let gestureScale = gestureRecognizer.scale
        scale += gestureScale - pinchGestureAnchorScale
            self.pinchGestureAnchorScale = gestureScale
        default:
            <#code#>
        }
    }
    
    
    
    
    
    
    
    
}

extension DetailImageViewController: UIGestureRecognizerDelegate{
    
    
    
    
}

