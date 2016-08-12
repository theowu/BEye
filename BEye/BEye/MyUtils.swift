//
//  MyUtils.swift
//  BEye
//
//  Created by Theo WU on 18/07/2016.
//  Copyright © 2016 Theo WU. All rights reserved.
//

import AVFoundation

var backgroundMusicPlayer: AVAudioPlayer!
var musicPlayer: AVAudioPlayer!

func playBackgroundMusic(fileName: String) {
    let resourceUrl = NSBundle.mainBundle().URLForResource(fileName, withExtension: nil)
    guard let url = resourceUrl else {
        print("Could not find file: \(fileName)")
        return
    }
    
    do {
        try backgroundMusicPlayer = AVAudioPlayer(contentsOfURL: url)
        backgroundMusicPlayer.numberOfLoops = -1
        backgroundMusicPlayer.prepareToPlay()
        backgroundMusicPlayer.play()
    } catch {
        print("Could not create audio player!")
        return
    }
}

func playMusicOnce(fileName: String) {
    let resourceUrl = NSBundle.mainBundle().URLForResource(fileName, withExtension: nil)
    guard let url = resourceUrl else {
        print("Could not find file: \(fileName)")
        return
    }
    
    do {
        try musicPlayer = AVAudioPlayer(contentsOfURL: url)
        musicPlayer.numberOfLoops = 0
        musicPlayer.prepareToPlay()
        musicPlayer.play()
    } catch {
        print("Could not create audio player!")
        return
    }
}

