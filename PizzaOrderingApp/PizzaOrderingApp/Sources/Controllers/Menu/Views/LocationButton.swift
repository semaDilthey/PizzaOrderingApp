//
//  LocationButton.swift
//  PizzaOrderingApp
//
//  Created by Семен Гайдамакин on 16.01.2024.
//

import UIKit

class LocationButton : UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        configure()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let label = UILabel()
    private let iconView = UIImageView()
    
    func setTitle(_ title: String) {
        label.text = title
    }
    
}


private extension LocationButton {
    
    func configure() {
        animateTouch(self)
        backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.SD.UIDisplayFont(size: 17, weight: .medium)
        label.textColor = Resources.Colors.black
        label.textAlignment = .center
        label.text = "Москва"
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.image = Resources.Images.Menu.location
        iconView.tintColor = Resources.Colors.black
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 2),
            iconView.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 8),
            iconView.heightAnchor.constraint(equalToConstant: 8),
            iconView.widthAnchor.constraint(equalToConstant: 14),
            
           
        ])
    }
    
    func addViews() {
        addSubview(label)
        addSubview(iconView)
    }
}
