//
//  ScoreModel.swift
//  Exact
//
//  Created by Victor Li on 8/13/20.
//  Copyright © 2020 Victor Li. All rights reserved.
//

import Foundation

enum ScoreType: CaseIterable {
    case computer_accurary
    case world_class
    case exceptional
    case great
    case good
    case average
    case not_too_shabby
    case off
}

struct ScoreModel {

    func getScoreString(_ scoreType : ScoreType) -> String {
        switch scoreType {
        case .computer_accurary:
            return "Computer Accuracy"
        case .world_class:
            return "World Class"
        case .exceptional:
            return "Exceptional"
        case .great:
            return "Great"
        case .good:
            return "Good"
        case .average:
            return "Average"
        case .not_too_shabby:
            return "Not Too Shabby"
        case .off:
            return "A Bit Off"
        }
    }

    func getScoreRange(_ scoreType : ScoreType) -> String {
        switch scoreType {
        case .computer_accurary:
            return "0-25"
        case .world_class:
            return "26-50"
        case .exceptional:
            return "51-100"
        case .great:
            return "101-200"
        case .good:
            return "201-300"
        case .average:
            return "301-700"
        case .not_too_shabby:
            return "701-1250"
        case .off:
            return "1251-5000"
        }
    }

    func getScoreType(_ score : Int) -> ScoreType {
        switch score {
        case 0...25:
            return ScoreType.computer_accurary
        case 26...50:
            return ScoreType.world_class
        case 51...100:
            return ScoreType.exceptional
        case 101...200:
            return ScoreType.great
        case 201...300:
            return ScoreType.good
        case 301...700:
            return ScoreType.average
        case 701...1250:
            return ScoreType.not_too_shabby
        case 1251...5000:
            return ScoreType.off
        default:
            return ScoreType.off
        }
    }


    func getMessage(_ score : Int) -> String {
        let scoreType = getScoreType(score)

        switch scoreType {
        case .computer_accurary:
            return "Your timing skills are E X A C T! Are you sure you're not a computer? Exceptionally well done! You beat the game!"
        case .world_class:
            return "Your timing skills are definitely one of the kind. You are WORLD CLASS!"
        case .exceptional:
            return "Your timing skills are absolutely exceptional! You're so extremely talented!"
        case .great:
            return "Your timing skills are getting even better. You've done a great job! Keep practicing to get even better"
        case .good:
            return "Your timing skills are better than the average person. But keep practicing if you want to get even better!"
        case .average:
            return "Your timing skills are pretty good. Keep practicing to get even better!"
        case .not_too_shabby:
            return "Not too shabby! But you know yourself you can do better!"
        case .off:
            return "Your timing skills were a bit off. But it's okay! Just bad luck this time. Keep trying!"
        }
    }

}
