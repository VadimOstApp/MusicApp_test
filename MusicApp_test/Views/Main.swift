//
//  ViewController.swift
//  MusicApp_test
//
//  Created by Vadim Ostashkevich on 3.09.22.
//

import UIKit
import AVFoundation
import MediaPlayer

class Main: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var slider: UISlider!
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private weak var playButton: UIButton!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var fullStatusLabel: UILabel!
    @IBOutlet private weak var endStatusLabel: UILabel!
    @IBOutlet private weak var holder: UIView!
    
    public var position: Int = 0
    
    public var sounds: [Sound] = []
    
    var timer: Timer?
    
//    var player: AVPlayer!
    var player: AVAudioPlayer?
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.configure()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSongs()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configure()
    }
    
    func configure() {
        let sound = sounds[position]
        
        let urlString = Bundle.main.path(forResource: sound.trackName, ofType: "mp3")
        
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            guard let urlString = urlString else {
                return
            }
            
            player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)
            guard let player = player else {
                return
            }

            player.play()
        }
        
        catch {
            print("error occurred")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let player = player {
            player.stop()
        }
    }
    
    
    func configureSongs() {
        sounds = [
            Sound(authName: "Ed Sheeran feat. Taylor Swift",
                  soundName: "The Joker And The Queen",
                  image: #imageLiteral(resourceName: "image1"), trackName: "song1"),
            Sound(authName: "Ed Sheeran",
                  soundName: "Thinking Out Loud",
                  image: #imageLiteral(resourceName: "image2"), trackName: "song2"),
            Sound(authName: "Avicii",
                  soundName: "Wake me up",
                  image: #imageLiteral(resourceName: "image3"), trackName: "song3")
        ]
    }
    
//    @IBAction func playAction() {
////        player.play()
//    }
    @IBAction private func didTapBackButton() {
        if position > 0 {
            position = position - 1
            player?.stop()
//            for subview in
        }
    }
    @IBAction private func didTapNextButton() {
        if position < (sounds.count - 1) {
            position = position + 1
            player?.pause()
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.configure()
            }
            
//            if position < (songs.count - 1) {
//                position = position + 1
//                player?.pause()
//                loadUI()
//                inActiveView()
//                DispatchQueue.main.asyncAfter(deadline: .now()) {
//                    self.configure()
//                }
//            }
        }
//        if position == sounds.count - 1 {
//            position = position + 1
//            player?.stop()
//        }
    }
        
    @IBAction private func didTapPlayPauseButton() {
        if player?.isPlaying == true {
            player?.pause()
        } else {
            player?.play()
        }
    }
    private func setupPlayer(sound: Sound) {
        guard let url = Bundle.main.path(forResource: sound.trackName, ofType: "mp3") else {
            return
        }
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 0.0001, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
        }
    }
    
    @objc func updateProgress() {
        
    }

}


extension Main: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sounds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as! MainCollectionViewCell
        cell.setup(sounds[indexPath.row])
        return cell
    }
}

extension Main: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        didTapNextButton()  
    }
}
