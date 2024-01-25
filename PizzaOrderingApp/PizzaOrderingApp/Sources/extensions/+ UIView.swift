//
//  + UIView.swift
//  PizzaOrderingApp
//
//  Created by Семен Гайдамакин on 16.01.2024.
//

import UIKit

extension UIView {

    
    func dropShadow(_ condition: Bool) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 4
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        if condition {
            layer.shadowOpacity = 0.15
        } else {
        
        layer.shadowOpacity = 0
 
        }
      
    }

    
    func animateTouch(_ button: UIButton) {
        button.addTarget(self, action: #selector(handleIn), for: [.touchDown, .touchDragInside])
        
        button.addTarget(self, action: #selector(handleOut), for: [.touchCancel, .touchDragOutside, .touchUpOutside, .touchUpInside, .touchDragExit])
       
    }
    
    @objc func handleIn() {
        UIView.animate(withDuration: 0.15) {
            self.alpha = 0.55
        }
    }
    
    @objc func handleOut() {
        UIView.animate(withDuration: 0.15) {
            self.alpha = 1
        }
    }
}

