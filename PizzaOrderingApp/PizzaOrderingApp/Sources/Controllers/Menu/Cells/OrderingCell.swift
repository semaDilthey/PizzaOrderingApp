//
//  OrderingCell.swift
//  PizzaOrderingApp
//
//  Created by Семен Гайдамакин on 17.01.2024.
//

import UIKit

final class OrderingCell: UICollectionViewCell {
    
    static let identifier = "OrderingCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let pizzaView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Буффало 1")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .center
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel : UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = UIFont.SD.UIDisplayFont(size: 17, weight: .bold)
        name.textColor = Resources.Colors.black
        name.text = "Название пиццы"
        return name
    }()
    
    private let descriptionLabel : UILabel = {
        let description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.font = UIFont.SD.UIDisplayFont(size: 13, weight: .thin)
        description.textColor = Resources.Colors.gray
        description.text = "Ветчина,шампиньоны, увеличинная порция моцареллы, томатный соус"
        description.numberOfLines = 0
        description.lineBreakMode = .byWordWrapping
        return description
    }()
    
    lazy private var priceButton : UIButton = {
        let priceButton = UIButton(type: .system)
        priceButton.translatesAutoresizingMaskIntoConstraints = false
        priceButton.setTitle(" от 345 р ", for: .normal)
        priceButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        priceButton.setTitleColor(Resources.Colors.active, for: .normal)
        priceButton.layer.borderWidth = 1
        priceButton.layer.borderColor = Resources.Colors.active.cgColor
        priceButton.layer.cornerRadius = 6
        priceButton.clipsToBounds = true
        priceButton.titleLabel?.font = UIFont.SD.UIDisplayFont(size: 13, weight: .thin)
        return priceButton
    }()
}

extension OrderingCell {
    
    private func configure() {
        let labelsStack = createStack(views: [nameLabel, descriptionLabel], axis: .vertical, spacing: 8, alignment: .leading, distirbution: .equalSpacing)
        let labelsPriceStack = createStack(views: [labelsStack, priceButton], axis: .vertical, spacing: 16, alignment: .trailing, distirbution: .fillProportionally)
        let imageLabelsPriceStack = createStack(views: [pizzaView, labelsPriceStack], axis: .horizontal, spacing: 32, alignment: .fill)
                
        addSubview(imageLabelsPriceStack)
        NSLayoutConstraint.activate([
            imageLabelsPriceStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            imageLabelsPriceStack.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            imageLabelsPriceStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            imageLabelsPriceStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),

        ])
        
    }
    
}

extension OrderingCell {
    
    func createStack(views : [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat, alignment: UIStackView.Alignment, distirbution: UIStackView.Distribution = .fill) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: views)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = axis
        stack.spacing = spacing
        stack.alignment = alignment
        stack.distribution = .equalSpacing
        return stack
    }
}
