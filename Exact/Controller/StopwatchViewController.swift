//
//  StopwatchViewController.swift
//  Exact
//
//  Created by Victor Li on 8/12/20.
//  Copyright © 2020 Victor Li. All rights reserved.
//

import UIKit

class StopwatchViewController: UIViewController {


    @IBOutlet weak var resetOuterView: UIView!
    @IBOutlet weak var resetButton: UIButton!


    @IBOutlet weak var startOuterView: UIView!
    @IBOutlet weak var startButton: UIButton!

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var warningLabel: UILabel!

    @IBOutlet weak var tableView: UITableView!

    
    var isRunning : Bool = false
    var readyToRun : Bool = true
    var mTime : CGFloat = 0
    var timer = Timer()

    var times = [CGFloat]()

    override func viewDidLoad() {
        super.viewDidLoad()
        createGradient(with: UIColor(hex: 0xFEE140, alpha: 1).cgColor, and: UIColor(hex: 0xFA709A, alpha: 1).cgColor)
        roundCorners()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 30

    }

    override func viewDidAppear(_ animated: Bool) {
        warningLabel.alpha = 1
    }

    func roundCorners() {
        resetOuterView.layer.borderWidth = 6
        resetOuterView.layer.borderColor = UIColor.white.cgColor
        resetOuterView.backgroundColor = .clear

        startOuterView.layer.borderWidth = 6
        startOuterView.layer.borderColor = UIColor.white.cgColor
        startOuterView.backgroundColor = .clear

        resetOuterView.layer.cornerRadius = 10
        startOuterView.layer.cornerRadius = 10
    }

    func createGradient(with c1: CGColor, and c2: CGColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.frame
        gradientLayer.colors = [c1, c2]
        gradientLayer.name = "backgroundGradient"
        view.layer.insertSublayer(gradientLayer, at: 0)
    }


    @IBAction func startButtonPressed(_ sender: UIButton) {
        if (readyToRun) {
            timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(increaseTime), userInfo: nil, repeats: true)
            isRunning = true
            readyToRun = false
            changeToStopText()
            warningLabel.alpha = 0
        } else {
            changeToStartText()
            if (isRunning) {
                timer.invalidate()
                keepScore()
                isRunning = false
            } else {
                pointToResetButton()
            }
        }
    }

    @objc func increaseTime()  {
        mTime += 1
        if (mTime >= 2000) {
            timer.invalidate()
            warningLabel.isHidden = false
            isRunning = false
            changeToStartText()
            
            self.warningLabel.alpha = 1
            if (self.warningLabel.transform == .identity) {
                UIView.animate(withDuration: 3, delay: 0, options: [.curveEaseIn, .curveEaseOut], animations: {
                    self.warningLabel.transform = .init(translationX: 0, y: -40)
                    self.warningLabel.alpha = 0

                }) { (finished) in
                    self.warningLabel.transform = .identity
                }
            }
        }
        updateTimerLabel()
    }

    @objc func updateTimerLabel() {  timerLabel.text = String(format: "%.3f", mTime / 1000)  }

    func changeToStopText() {  startButton.setTitle("Stop", for: .normal)  }

    func changeToStartText() {  startButton.setTitle("Start", for: .normal)  }

    func pointToResetButton() {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: .autoreverse, animations: {
            UIView.modifyAnimations(withRepeatCount: 2, autoreverses: true) {
                self.resetOuterView.transform = .init(scaleX: 1.5, y: 1.5)
            }
        }) { (finished) in
            if (finished) {
                self.resetOuterView.transform = .identity
            }
        }
    }


    @IBAction func resetButtonPressed(_ sender: UIButton) {
        mTime = 0
        updateTimerLabel()
        isRunning = false
        readyToRun = true
    }

    func keepScore() {
        times.append(mTime / 1000)
        print(times)
        tableView.reloadData()

        if (times.count >= 5) {
            activityFinished()
        }

    }

    func activityFinished() {
        performSegue(withIdentifier: "StopwatchToFinish", sender: self)
        
    }


}

extension StopwatchViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Times.count: \(times.count)")
        return times.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusableCell", for: indexPath) as! TrialTableViewCell
        cell.timeLabel.text = String(format: "%.3f", times[indexPath.row])
        cell.trialLabel.text = "Trial \(indexPath.row + 1)"
        print("Returning cell ")
        return cell
    }

}

extension StopwatchViewController : FinishViewControllerDelegate {
    func playAgainWasPressed() {
        times = []
        mTime = 0
        isRunning = false
        readyToRun = true
        updateTimerLabel()
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StopwatchToFinish" {
            let dest = segue.destination as! FinishViewController
            dest.delegate = self
            dest.times = times
        }
    }


}

