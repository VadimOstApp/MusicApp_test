//
//  MainCollectionViewCell.swift
//  MusicApp_test
//
//  Created by Vadim Ostashkevich on 3.09.22.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: MainCollectionViewCell.self)
    
    @IBOutlet private weak var imageSound: UIImageView!
    @IBOutlet private weak var authNameLabel: UILabel!
    @IBOutlet private weak var soundNameLabel: UILabel!
    
    func setup(_ sound: Sound) {
        imageSound.image = sound.image
        authNameLabel.text = sound.authName
        soundNameLabel.text = sound.soundName
    }
}
