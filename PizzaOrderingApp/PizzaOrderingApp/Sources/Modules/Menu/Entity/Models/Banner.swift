//
//  Banner.swift
//  PizzaOrderingApp
//
//  Created by Семен Гайдамакин on 18.01.2024.
//

import UIKit

struct Banner {
    
    var image : UIImage
    
    static func imagesGeneration() -> [Banner] {
        
        let banners: [Banner] = Resources.Images.Banners.allCases.compactMap { banner in
            guard let image = banner.image else { return nil }
            return Banner(image: image)
        }
        
        return banners
    }
}
