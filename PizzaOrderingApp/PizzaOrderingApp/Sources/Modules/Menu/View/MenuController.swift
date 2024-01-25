//
//  MenuController.swift
//  PizzaOrderingApp
//
//  Created by Семен Гайдамакин on 16.01.2024.
//

import UIKit

protocol MenuViewProtocol: AnyObject {
    
    var presenter: MenuPresenterProtocol { get }
    
    // PRESENTER -> VIEW
    func showMenuItems(items: [Menu])
    func scrollTo(index: Int)
}

final class MenuController : BaseController {
    
    let presenter : MenuPresenterProtocol
    
    init(presenter : MenuPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()  
        presenter.viewDidLoad()
    }

    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
}

extension MenuController {
    
    override func addViews() {
        addNavBarItem(at: .left, title: "Зима")
        view.addSubview(collectionView)

    }
    
    override func configure() {
        super.configure()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = Resources.Colors.background
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: MenuCell.identifier)
        collectionView.register(PromotionCell.self, forCellWithReuseIdentifier: PromotionCell.identifier)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.identrifier)
        collectionView.collectionViewLayout = createLayout()
        
    }
    
    override func layoutViews() {

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

    }
    
    override func navBarLeftItemHandler() {
        let colors = [UIColor.red, UIColor.green, UIColor.yellow]
            view.backgroundColor = colors.randomElement()
    }
}

extension MenuController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0 : return 3
        case 1: return presenter.getItemCount() 
        default: return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PromotionCell.identifier, for: indexPath) as! PromotionCell
            let banners = Banner.imagesGeneration()
            cell.set(image: banners[indexPath.row].image)
            
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCell.identifier, for: indexPath) as! MenuCell
            cell.setRoundedCorners(at: indexPath)
            if let items = presenter.getItem(at: indexPath.row) {
                cell.configureCell(with: items)
            }
          
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.identrifier, for: indexPath) as! HeaderView

        header.callBack = { [weak self] category in
            self?.presenter.selectCategory(category: category)
        }
        return header
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let collectionView = scrollView as? UICollectionView,
              let header = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 1)) as? HeaderView else {
            return
        }
        let headerTop = header.frame.origin.y

        headerTop > 112 ? header.dropShadow(true) :  header.dropShadow(false)
    }
}

extension MenuController : MenuViewProtocol {
    
    func showMenuItems(items: [Menu]) {
        DispatchQueue.main.async { [self] in
            let section = IndexSet(integer: 1)
            collectionView.reloadSections(section)
        }
    }
    
    func scrollTo(index: Int) {
        var index2 : Int {
            switch index {
            case 0 : return 0
            case 1 : return 5
            case 2 : return 8
            case 3 : return 10
            default: return index
            }
        }
        guard let header = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 1)) as? HeaderView else {
            return
        }
        let indexPathHeader = IndexPath(item: index, section: 0)
        header.collectionView.scrollToItem(at: indexPathHeader, at: .left, animated: true)
        
        let indexPath = IndexPath(row: index2, section: 1)
        collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
      
        
    }
    
    
}
