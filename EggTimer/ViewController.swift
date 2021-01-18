//
//  ViewController.swift
//  EggTimer
//
//  Created by Fady Magdy on 18/12/2020.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var  player:AVAudioPlayer?
    
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    
    let eggTimes:[String:Int] = ["Soft":3,"Medium":4,"Hard":7]
    
    @IBOutlet weak var mainLabel: UILabel!

   
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    
    
    
    
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        let hardness = sender.currentTitle!
       
        progressBar.progress = 0.0
        mainLabel.text = hardness
        secondsPassed = 0
        
        
        
        
       
        
        totalTime = eggTimes[hardness]!
        
      /*  switch hardness {
        case "Soft":
            secondsRemaining = eggTimes[hardness]!
            print(secondsRemaining)
        case "Medium":
            secondsRemaining = eggTimes[hardness]!
            print(secondsRemaining)
        case "Hard":
            secondsRemaining = eggTimes[hardness]!
            print(secondsRemaining)
        default:
            print("error")        } */
        
        
       timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(UIMenuController.update), userInfo: nil, repeats: true)
        
      
            
        }
    
    
    
   @objc func update() {
        if secondsPassed < totalTime {
            
            
             secondsPassed += 1
            
            let percentageProgress = Float( secondsPassed) / Float(totalTime)
            progressBar.progress = Float(percentageProgress)
            
           
        }
            else {
                timer.invalidate()
                mainLabel.text = "Done"
                playSound()
            }
        }
    

    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }

}

    
    
    
    
    

