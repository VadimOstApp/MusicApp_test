//
//  UISlider+Extension.swift
//  MusicApp_test
//
//  Created by Vadim Ostashkevich on 5.09.22.
//

import Foundation
import UIKit

@IBDesignable
class DesignableSlider: UISlider {
    @IBInspectable var thumbImage: UIImage? {
        didSet {
            setThumbImage(thumbImage, for: .normal)
        }
    }
}
