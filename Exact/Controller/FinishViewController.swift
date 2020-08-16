//
//  FinishViewController.swift
//  Exact
//
//  Created by Victor Li on 8/13/20.
//  Copyright © 2020 Victor Li. All rights reserved.
//

import UIKit

protocol FinishViewControllerDelegate {
    func playAgainWasPressed()
}

class FinishViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!


    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var scoreCalculationButton: UIButton!

    var delegate : FinishViewControllerDelegate?
    var times : [CGFloat]?
    var score : Int = 0

    let scoreModel = ScoreModel()


    override func viewDidLoad() {
        super.viewDidLoad()
        createGradient(with: UIColor(hex: 0xFEE140, alpha: 1).cgColor, and: UIColor(hex: 0xFA709A, alpha: 1).cgColor)
        roundAndColorButtons()
        calculateScore()
        displayScoreInfo()
        
    }

    func createGradient(with c1: CGColor, and c2: CGColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.frame
        gradientLayer.colors = [c1, c2]
        gradientLayer.name = "backgroundGradient"
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    func roundAndColorButtons() {
        playAgainButton.layer.cornerRadius = playAgainButton.frame.height / 3
        scoreCalculationButton.layer.cornerRadius = scoreCalculationButton.frame.height / 3

        playAgainButton.layer.borderWidth = 5
        scoreCalculationButton.layer.borderWidth = 5
        playAgainButton.layer.borderColor = UIColor.white.cgColor
        scoreCalculationButton.layer.borderColor = UIColor.white.cgColor

    }




    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        delegate?.playAgainWasPressed()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func scoreCalculationButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "FinishToScoreCalculation", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FinishToScoreCalculation" {
            let destVC = segue.destination as! ScoreCalculationViewController
            destVC.times = times
        }
    }

    func calculateScore() {
        if let safeTimes = times {
            if safeTimes.count == 5 {
                var diff : Int = 0
                for time in safeTimes {

                    diff += (Int(abs(time * 1000 - 1000)))
                }
                score = diff
                return
            }
        }
        score = 5000
    }

    func displayScoreInfo() {
        scoreLabel.text = "Your score was \(score)!"
        descriptionLabel.text = scoreModel.getMessage(score)
    }

}
