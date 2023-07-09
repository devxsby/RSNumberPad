//
//  CALayer+.swift
//  RSNumberPad
//
//  Created by devxsby on 2023/07/03.
//

import UIKit

extension CALayer {
    func applyShadow(color: CGColor = UIColor.black.cgColor,
                     opacity: Float = 0.3,
                     offset: CGSize = .zero,
                     radius: CGFloat = 2,
                     masksToBounds: Bool = false) {
        self.shadowColor = color
        self.shadowOpacity = opacity
        self.shadowOffset = offset
        self.shadowRadius = radius
        self.masksToBounds = masksToBounds
    }
}
