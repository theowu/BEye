//
//  ViewController.swift
//  BEye
//
//  Created by Theo WU on 17/07/2016.
//  Copyright © 2016 Theo WU. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    @IBOutlet weak var mySlider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var musicButton: UIButton!
    @IBOutlet weak var soundEffectButton: UIButton!
    
    
    var musicIsBeingPlayed = true
    var soundEffectOn = true
    var currentValue = 50
    var targetValue = 0
    var score = 0
    var round = 0
    var difference: Int {
        get {
            return abs(currentValue-targetValue)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playBackgroundMusic("bgMusic.mp3")
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        mySlider.setThumbImage(thumbImageNormal, forState: .Normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        mySlider.setThumbImage(thumbImageHighlighted, forState: .Highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        if let trackLeftImage = UIImage(named: "SliderTrackLeft") {
            let trackLeftResizable = trackLeftImage.resizableImageWithCapInsets(insets)
            mySlider.setMinimumTrackImage(trackLeftResizable, forState: .Normal)
        }
        if let trackRightImage = UIImage(named: "SliderTrackRight") {
            let trackRightResizable = trackRightImage.resizableImageWithCapInsets(insets)
            mySlider.setMaximumTrackImage(trackRightResizable, forState: .Normal)
        }
        
        startNewGame()
    }
    
    @IBAction func showAlert() {
        score += 100 - difference
        
        
        let title: String
        if difference == 0 {
            if soundEffectOn {
                playMusicOnce("perfect.wav")
            }
            title = "Perfect!"
            score += 100
        } else if difference < 5 {
            title = "You almost had it!"
            if soundEffectOn {
                playMusicOnce("almost.wav")
            }
            score += 50
        } else if difference < 10 {
            if soundEffectOn {
                playMusicOnce("pretty.wav")
            }
            title = "Pretty good!"
        } else {
            if soundEffectOn {
                playMusicOnce("bad.wav")
            }
            title = "Not even close ..."
        }
        
        let message = "The value of the slider is: \(currentValue)\n The target value is: \(targetValue)\n The difference is: \(difference) \n"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: {action in self.startNewRound()})
        alert.addAction(action)
        
        presentViewController(alert, animated: true, completion: nil)
    }

    @IBAction func sliderMoved(sender: UISlider) {
        currentValue = lroundf(sender.value)
    }

    func startNewRound() {
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        
        updateLabels()
        
        currentValue = 50
        mySlider.value = Float(currentValue)
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    @IBAction func startOver() {
        startNewGame()
        
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        view.layer.addAnimation(transition, forKey: nil)
    }
    
    func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }
    
    @IBAction func toggleMusicPlayStatus() {
        if musicIsBeingPlayed {
            backgroundMusicPlayer.stop()
            musicIsBeingPlayed = false
            musicButton.setImage(UIImage(named: "PlayBackgroundMusic"), forState: .Normal)
        } else {
            playBackgroundMusic("bgMusic.mp3")
            musicIsBeingPlayed = true
            musicButton.setImage(UIImage(named: "StopBackgroundMusic"), forState: .Normal)
        }
    }
    
    @IBAction func toggleSoundEffectStatus() {
        if soundEffectOn {
            soundEffectOn = false
            soundEffectButton.setImage(UIImage(named: "TurnOnSoundEffect"), forState: .Normal)
        } else {
            soundEffectOn = true
            soundEffectButton.setImage(UIImage(named: "TurnOffSoundEffect"), forState: .Normal)
        }
    }
}

