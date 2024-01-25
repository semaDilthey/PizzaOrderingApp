//
//  HeaderView.swift
//  PizzaOrderingApp
//
//  Created by Семен Гайдамакин on 17.01.2024.
//

import UIKit

final class HeaderView : UICollectionReusableView {
    
    static let identrifier = "HeaderView"

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCollection()
        layoutCollection()
    }
    
    var callBack : ((String)->())?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var tabs = ["Пицца", "Комбо", "Десерты", "Напитки", "Закуски"]
    var collectionView : UICollectionView!
    
    private func configureCollection() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = Resources.Colors.background
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HeaderCell.self, forCellWithReuseIdentifier: HeaderCell.identifier)
    }
    
    private func layoutCollection() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

extension HeaderView : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderCell.identifier, for: indexPath) as! HeaderCell
        cell.configureCell(with: tabs[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            callBack?(tabs[indexPath.row])
        }
    }
    
    
}

extension HeaderView : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          let tab = tabs[indexPath.row]

              // Вычисляет размер ячейки на основе размера текста
            let textAttributes = [NSAttributedString.Key.font: UIFont.SD.UIDisplayFont(size: 13, weight: .extraBold)] // Устанавливает  шрифт
        let boundingRect = (tab as NSString).boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: 30), options: .usesLineFragmentOrigin, attributes: textAttributes as [NSAttributedString.Key : Any], context: nil)

              // Добавляет дополнительное пространство, чтобы не быть слишком узким
              let cellWidth = ceil(boundingRect.width) + 35 // 20 - небольшой отступ
              let cellHeight = ceil(boundingRect.height) + 16 // Высота ячейки

              return CGSize(width: cellWidth, height: cellHeight)
      }
}
