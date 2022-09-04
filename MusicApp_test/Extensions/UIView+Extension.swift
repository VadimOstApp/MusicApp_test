//
//  UIView+Extension.swift
//  MusicApp_test
//
//  Created by Vadim Ostashkevich on 3.09.22.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return cornerRadius }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
