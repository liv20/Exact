//
//  ScoreCalculationViewController.swift
//  Exact
//
//  Created by Victor Li on 8/15/20.
//  Copyright © 2020 Victor Li. All rights reserved.
//

import UIKit

class ScoreCalculationViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var times : [CGFloat]? = [1.024, 1.025, 1.026, 1.020, 0.999]
    var milliTimes : [Int]?
    var offBy : [Int]?
    var score : Int?
    let scoreModel = ScoreModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        createGradient(with: UIColor(hex: 0xFEE140, alpha: 1).cgColor, and: UIColor(hex: 0xFA709A, alpha: 1).cgColor)
        tableView.dataSource = self
        tableView.delegate = self
        computeMilliTimesAndSetOffTimesAndScore()
    }

     func createGradient(with c1: CGColor, and c2: CGColor) {
         let gradientLayer = CAGradientLayer()
         gradientLayer.frame = view.frame
         gradientLayer.colors = [c1, c2]
         gradientLayer.name = "backgroundGradient"
         view.layer.insertSublayer(gradientLayer, at: 0)
     }

    func computeMilliTimesAndSetOffTimesAndScore() {
        milliTimes = []
        if let safeTimes = times {
            for safeTime in safeTimes {
                milliTimes!.append(Int(1000 * safeTime))
            }
        }

        offBy = []
        score = 0
        if let safeMTimes = milliTimes {
            for safeMTime in safeMTimes {
                offBy!.append(abs(safeMTime - 1000))
                score!  += abs(safeMTime - 1000)
            }
        }

    }


}

extension ScoreCalculationViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }


    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 90)


        let title = UILabel()
        title.frame = view.frame
        title.textColor = .white
        title.font = UIFont(name: "HelveticaNeue-Medium", size: 30)
        title.textAlignment = .center
        title.numberOfLines = 0
        switch section {
        case 0:
            title.text = "Score Ranges"
        case 1:
            title.text = "Step 1: Converted all times into milliseconds"
        case 2:
            title.text = "Step 2: Find how far off each trial is"
        case 3:
            title.text = "Step 3: Combine the differences for each trial!"
        default:
            title.text = ""
        }
        view.addSubview(title)



        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 90
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }




    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return ScoreType.allCases.count + 1
        case 1:
            return times!.count + 1
        case 2:
            return times!.count + 1
        case 3:
            return 1
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusableCell", for: indexPath) as! TrialTableViewCell


        cell.timeLabel.text = "Hi"
        cell.trialLabel.text = "Trial"
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.trialLabel.text = "Level"
                cell.timeLabel.text = "Score Range"
                cell.trialLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
                cell.timeLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
            case 1...ScoreType.allCases.count:
                cell.trialLabel.text = scoreModel.getScoreString(ScoreType.allCases[indexPath.row - 1])
                cell.timeLabel.text = scoreModel.getScoreRange(ScoreType.allCases[indexPath.row - 1])
            default: break
            }
        case 1:
            switch indexPath.row {
            case 0:
                cell.trialLabel.text = "Time (s)"
                cell.timeLabel.text = "Time (ms)"
                cell.trialLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
                cell.timeLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
            case 1...times!.count:
                cell.trialLabel.text = "\(times![indexPath.row - 1])"
                cell.timeLabel.text = "\(milliTimes![indexPath.row - 1])"
                cell.trialLabel.font = UIFont(name: "Helvetica Neue", size: 17)
                cell.timeLabel.font = UIFont(name: "Helvetica Neue", size: 17)
            default:
                break
            }
        case 2:
            switch indexPath.row {
            case 0:
                cell.trialLabel.text = "Time (ms)"
                cell.timeLabel.text = "Off by (ms)"
                cell.trialLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
                cell.timeLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
            case 1...times!.count:
                cell.trialLabel.text = "\(milliTimes![indexPath.row - 1])"
                cell.timeLabel.text = "\(offBy![indexPath.row - 1])"
            default:
                break
            }
        case 3:
            cell.trialLabel.textAlignment = .left
            cell.timeLabel.textAlignment = .left

            cell.trialLabel.text = "Score:  "
            cell.timeLabel.text = "\(score!)"
            cell.trialLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 25)
            cell.timeLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 25)


        default:
            break
        }
        return cell

    }


}
