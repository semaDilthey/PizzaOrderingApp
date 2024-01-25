//
//  MenuCell.swift
//  PizzaOrderingApp
//
//  Created by Семен Гайдамакин on 17.01.2024.
//

import UIKit

final class MenuCell: UICollectionViewCell {
    
    static let identifier = "MenuCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSpacingBetweenCells()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        configureCell(with: nil)
        contentView.clipsToBounds = false
    }
    
    public func configureCell(with menu: MenuModelProtocol?) {
        guard let menu else { return }
        pizzaView.set(imageURL: menu.imageUrl)
        nameLabel.text = menu.name
        descriptionLabel.text = menu.description
        priceButton.titleLabel?.text = "от " + String(menu.price) + " р"
    }
    
    private let pizzaView : WebImageView = {
        let imageView = WebImageView()
        imageView.image = UIImage(named: "Буффало 1")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel : UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = UIFont.SD.UIDisplayFont(size: 17, weight: .bold)
        name.textColor = Resources.Colors.black
        name.numberOfLines = 0
        name.lineBreakMode = .byWordWrapping
        name.text = "Название пиццы"
        return name
    }()
    
    private let descriptionLabel : UILabel = {
        let description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.font = UIFont.SD.UIDisplayFont(size: 14, weight: .thin)
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
    
    func setRoundedCorners(at indexPath: IndexPath) {
        if indexPath.row == 0 {
            contentView.clipsToBounds = true
            contentView.layer.cornerRadius = 30
            contentView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else {
            contentView.clipsToBounds = false
            contentView.layer.cornerRadius = 0
        }
    }

    private func addSpacingBetweenCells() {
        let margins = UIEdgeInsets(top: 0, left: 0, bottom: 1, right: 0)
        contentView.frame = contentView.frame.inset(by: margins)
        contentView.backgroundColor = .white
    }
    
   
}

extension MenuCell {
    
    private func configure() {
        let labelsStack = createStack(views: [nameLabel, descriptionLabel], axis: .vertical, spacing: 8, alignment: .leading, distirbution: .fillEqually)
        let labelsPriceStack = createStack(views: [labelsStack, priceButton], axis: .vertical, spacing: 8, alignment: .trailing, distirbution: .fillProportionally)
        
        contentView.addSubview(pizzaView)
        contentView.addSubview(labelsPriceStack)
        
        NSLayoutConstraint.activate([
            pizzaView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            pizzaView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            pizzaView.heightAnchor.constraint(equalToConstant: 132),
            pizzaView.widthAnchor.constraint(equalToConstant: 132),
            
            labelsPriceStack.leadingAnchor.constraint(equalTo: pizzaView.trailingAnchor, constant: 32),
            labelsPriceStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            labelsPriceStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            labelsPriceStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            
            priceButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            nameLabel.leadingAnchor.constraint(equalTo: pizzaView.trailingAnchor, constant: 32),
            descriptionLabel.leadingAnchor.constraint(equalTo: pizzaView.trailingAnchor, constant: 32)
            
        ])
    }
    
}

extension MenuCell {
    
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
