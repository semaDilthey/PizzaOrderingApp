//
//  MenuController.swift
//  PizzaOrderingApp
//
//  Created by Семен Гайдамакин on 16.01.2024.
//

import UIKit

enum Sections {
    case promotion
    case ordering
}

final class MenuController : BaseController {
    
    override func viewDidLoad() {
        super.viewDidLoad()  
    }
    
    /// Эта будет в 1 секцию, только для рекламок
    private let promotionCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    /// Эта 2 секции, либо хедер с секцией
    private let orderingCollectionVIew = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
}

extension MenuController {
    
    override func addViews() {
        addNavBarItem(at: .left, title: "Зима")
        view.addSubview(promotionCollectionView)
        view.addSubview(orderingCollectionVIew)

    }
    
    override func configure() {
        promotionCollectionView.delegate = self
        promotionCollectionView.dataSource = self
        promotionCollectionView.register(PromotionCell.self, forCellWithReuseIdentifier: PromotionCell.identifier)
        promotionCollectionView.collectionViewLayout = createLayout(for: .promotion)
        
        orderingCollectionVIew.delegate = self
        orderingCollectionVIew.dataSource = self
        orderingCollectionVIew.register(OrderingCell.self, forCellWithReuseIdentifier: OrderingCell.identifier)
        orderingCollectionVIew.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.identrifier)
        orderingCollectionVIew.collectionViewLayout = createLayout(for: .ordering)
    }
    
    override func layoutViews() {
        
        promotionCollectionView.translatesAutoresizingMaskIntoConstraints = false
        promotionCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        promotionCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        promotionCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        promotionCollectionView.heightAnchor.constraint(equalToConstant: 112).isActive = true
        
        orderingCollectionVIew.translatesAutoresizingMaskIntoConstraints = false
        orderingCollectionVIew.topAnchor.constraint(equalTo: promotionCollectionView.bottomAnchor, constant: 16).isActive = true
//        orderingCollectionVIew.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true

        orderingCollectionVIew.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        orderingCollectionVIew.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        orderingCollectionVIew.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

    }
    
    override func navBarLeftItemHandler() {
        let colors = [UIColor.red, UIColor.green, UIColor.yellow]
        
            view.backgroundColor = colors.randomElement()
    }
}

extension MenuController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
            case promotionCollectionView: return 3
            case orderingCollectionVIew: return 4
            default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case promotionCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PromotionCell.identifier, for: indexPath) as! PromotionCell
            return cell
        case orderingCollectionVIew:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OrderingCell.identifier, for: indexPath) as! OrderingCell
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.identrifier, for: indexPath) as! HeaderView
        return header
    }
}

extension MenuController {
    
    private func createLayout(for section: Sections) -> UICollectionViewCompositionalLayout {
            return UICollectionViewCompositionalLayout { sectionNumber, _ -> NSCollectionLayoutSection? in
                return self.createSection(section)
               }
        }
        
        private func createLayoutItem(widthFraction: CGFloat, heightFraction: CGFloat) -> NSCollectionLayoutItem {
             let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(widthFraction), heightDimension: .fractionalHeight(heightFraction))
             let item = NSCollectionLayoutItem(layoutSize: itemSize)
             return item
         }
        
         // Функция создания layout group
        private func createGroup(layoutSize: NSCollectionLayoutSize, subitems: [NSCollectionLayoutItem]) -> NSCollectionLayoutGroup {
             return NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize, subitems: subitems)
             }
       
         
    private func createSection(_ section: Sections) -> NSCollectionLayoutSection {
        switch section {
        case .promotion:
            let item = createLayoutItem(widthFraction: 1, heightFraction: 1)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16)
            let group = createGroup(layoutSize: .init(widthDimension: .fractionalWidth(0.85), heightDimension: .absolute(112)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0)
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
    
            return section
        case .ordering:
            let item = createLayoutItem(widthFraction: 1, heightFraction: 1)
            let group = createGroup(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(180)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = [createHeaderItem(height: 50, kind: UICollectionView.elementKindSectionHeader)]
            return section
        }
    }
    
    private func createHeaderItem(height: CGFloat, kind: String) -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(height))
        let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: kind, alignment: .top)
        headerElement.pinToVisibleBounds = true
        return headerElement
    }
}


extension MenuController : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let topOffset = CGPoint(x: 0, y: 0)
    }
    
}
