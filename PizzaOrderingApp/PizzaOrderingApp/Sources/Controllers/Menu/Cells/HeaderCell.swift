//
//  HeaderCell.swift
//  PizzaOrderingApp
//
//  Created by Семен Гайдамакин on 17.01.2024.
//

import UIKit

final class HeaderCell: UICollectionViewCell {
    
    static let identifier = "HeaderCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    override var isSelected: Bool {
        didSet {
            configureState(isSelected: isSelected)
        }
    }
    
    private func configureState(isSelected : Bool) {
        if isSelected {
            title.font = UIFont.SD.UIDisplayFont(size: 13, weight: .extraBold)
            background.backgroundColor = Resources.Colors.Cells.unSelected
            title.textColor = Resources.Colors.Cells.selected
            background.layer.borderWidth = 0
        } else {
            title.font = UIFont.SD.UIDisplayFont(size: 13, weight: .thin)
            background.backgroundColor = .clear
            background.layer.borderWidth = 1
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with text: String) {
        title.text = text
    }
    
    private let title : UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.SD.UIDisplayFont(size: 13, weight: .thin)
        title.textColor = Resources.Colors.Cells.selected
        title.text = "Pizza"
        return title
    }()
    
    private let background : UIView = {
        let background = UIView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.layer.cornerRadius = 16
        background.clipsToBounds = true
        background.layer.borderWidth = 1
        background.layer.borderColor = Resources.Colors.Cells.unSelected.cgColor
        return background
    }()
}

extension HeaderCell {
    
    private func configure() {
        contentView.addSubview(background)
        contentView.addSubview(title)

        
        NSLayoutConstraint.activate([
            background.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            background.topAnchor.constraint(equalTo: contentView.topAnchor),
            background.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            
//            
//            title.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 24),
//            title.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -24),
//            title.topAnchor.constraint(equalTo: background.topAnchor, constant: 8),
//            
            title.centerXAnchor.constraint(equalTo: background.centerXAnchor),
            title.centerYAnchor.constraint(equalTo: background.centerYAnchor)

            

        ])
    }
    
}
