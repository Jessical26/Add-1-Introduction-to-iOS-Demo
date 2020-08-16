//
//  ViewController.swift
//  Add 1
//
//  Created by Jessica Liang on 8/14/20.
//  Copyright © 2020 Jessica Liang. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel?
    @IBOutlet weak var timeLabel: UILabel?
    @IBOutlet weak var numberLabel: UILabel?
    @IBOutlet weak var inputField: UITextField?
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateScoreLabel()
        updateNumberLabel()
        updateTimeLabel()
    }
    
    func updateScoreLabel() {
        scoreLabel?.text = String(score)
    }
    
    func updateNumberLabel(){
        numberLabel?.text = String.randomNumber(length: 4)
    }

    @IBAction func inputFieldDidChange() {
        //guard let evaluates whether an expression is nil.
        //If it's not nil, the nonoptional values are assigned to their respective constants
        //If nil, the else block is invoked
        guard let numberText = numberLabel?.text, let inputText = inputField?.text else {
            return
        }
        //guard that input.text has length 4, else exit
        //guard statement forces you to transfer control out of scope, aka exit the function
        guard inputText.count == 4 else {
            return
        }
        
        var isCorrect = true
        for n in 0..<4 {
            var input = inputText.integer(at: n)
            let number = numberText.integer(at: n)
            
            if input == 0 {
                input = 10
            }
            
            if input != number + 1 {
                isCorrect = false
                break
            }
        }
        
        if isCorrect {
            score += 1
        } else {
            score -= 1
        }
        
        updateNumberLabel()
        updateScoreLabel()
        inputField?.text = ""
        
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                if self.seconds == 0 {
                    self.finishGame()
                } else if self.seconds <= 60 {
                    self.seconds -= 1
                    self.updateTimeLabel()
                }
                
            }
        }
        
    }
    
    var timer:Timer?
    var seconds = 60
    
    func updateTimeLabel() {
        let min = (seconds / 60) % 60
        let sec = seconds % 60
        
        //zero padded strings. That way, 7 seconds is 07
        timeLabel?.text = String(format: "%02d", min) + ":" + String(format: "%02d", sec)
    }
    
    func finishGame() {
        timer?.invalidate()
        timer = nil
        //UIAlertController is a popup dialog that shows a bit of text and a button.
        let alert = UIAlertController(title: "Time's Up!", message: "Haha you ran out of time! You got a score of \(score) points. Mehhhhhh. You could do better", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok, lets start another game", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        updateTimeLabel()
        updateScoreLabel()
        updateNumberLabel()
    }
    


}

