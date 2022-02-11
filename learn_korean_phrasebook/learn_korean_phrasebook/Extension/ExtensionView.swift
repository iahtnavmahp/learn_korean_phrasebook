//
//  ExtensionView.swift
//  learn_korean_phrasebook
//
//  Created by Pham Van Thai on 26/11/2021.
//

import Foundation
import UIKit
extension UIView {

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         self.layer.mask = mask
    }

}
