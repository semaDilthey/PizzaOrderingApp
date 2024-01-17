//
//  + UIFont.swift
//  PizzaOrderingApp
//
//  Created by Семен Гайдамакин on 16.01.2024.
//

import UIKit

extension UIFont {
    
    enum SD {
        
        enum SFUIDisplayFont: Int {
                case thin = 400
                case medium = 500
                case bold = 600
                case extraBold = 700
                
                var nameFont: String {
                    switch self {
                    case .thin:
                        return "SF UI Display Thin"
                    case .medium:
                        return "SF UI Display Medium"
                    case .bold:
                        return "SF UI Display Semibold"
                    case .extraBold:
                        return "SF UI Display Bold"
                    }
               
                }
            }
            
            static func UIDisplayFont(size fontSize: CGFloat, weight fontWeight: SFUIDisplayFont) -> UIFont? {
                UIFont(name: fontWeight.nameFont, size: fontSize)
            }
    }
}
