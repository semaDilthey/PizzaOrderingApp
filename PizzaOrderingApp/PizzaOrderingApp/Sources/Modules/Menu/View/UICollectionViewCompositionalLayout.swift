//
//  UICollectionViewCompositionalLayout.swift
//  PizzaOrderingApp
//
//  Created by Семен Гайдамакин on 24.01.2024.
//

import Foundation
import UIKit

extension MenuController {
    
    enum Sections {
        case promotion
        case ordering
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
            return UICollectionViewCompositionalLayout { sectionNumber, _ -> NSCollectionLayoutSection? in
                switch sectionNumber {
                    case 0: return self.createSection(.promotion)
                    case 1: return self.createSection(.ordering)
                    default: return self.createSection(.ordering)
                }
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
            item.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 16)
            let group = createGroup(layoutSize: .init(widthDimension: .fractionalWidth(0.85), heightDimension: .absolute(112)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0)
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            return section
            
        case .ordering:
            let item = createLayoutItem(widthFraction: 1, heightFraction: 1)
            let group = createGroup(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(180)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = [createHeaderItem(height: 62, kind: UICollectionView.elementKindSectionHeader)]
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
