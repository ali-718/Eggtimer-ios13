//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        progressBar.isHidden = true
    }
    
    let sofTime = 5
    let mediumTime = 8
    let hardTime = 12
    var secondsRemaining:Float = 60
    var totalSeconds:Float = 0
    let eggTimes = ["Soft":10,"Medium":200,"Hard":300]
    var bombSoundEffect: AVAudioPlayer?
    
    var timer = Timer()
   
    @objc func sayHello()
    {
        let perc:Float = Float(secondsRemaining / totalSeconds)
        print("total seconds: \(totalSeconds)")
        print("remainng seconds: \(secondsRemaining)")
        print("perc: \(perc)")
        let progressViewPercentage:Float = abs(perc - 1.00)
        print("progress: \(progressViewPercentage)")
        
        progressBar.progress = progressViewPercentage
        
        if secondsRemaining > 0 {
            secondsRemaining -= 1
        }
        else{
            timer.invalidate()
            Label.text = "DONE"
            
            let path = Bundle.main.path(forResource: "alarm_sound.mp3", ofType:nil)!
            let url = URL(fileURLWithPath: path)
            
            do {
                bombSoundEffect = try AVAudioPlayer(contentsOf: url)
                bombSoundEffect?.play()
            } catch {
                // couldn't load file :(
            }
            
        }
    }
    
    @IBAction func HardnessSelected(_ sender: UIButton) {
        Label.text = "Boiling"
         timer.invalidate()
        let hardness = sender.currentTitle!
         timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(sayHello), userInfo: nil, repeats: true)
        
        
        secondsRemaining = Float(eggTimes[hardness]!)
        totalSeconds = Float(eggTimes[hardness]!)
        progressBar.isHidden = false
    }
    
    @IBOutlet weak var Label: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
}
