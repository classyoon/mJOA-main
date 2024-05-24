//
//  JOAQuestion.swift
//  mJOA
//
//  Created by Tim Yoon on 5/23/24.
//

import Foundation

enum JOAQuestion : String, CaseIterable, Codable{
    case motorHand, motorLeg, sensation, sphincter
    
    var text: String {
        switch self {
        case .motorHand:
            return "I. Motor dysfunction score of the upper extremities"
        case .motorLeg:
            return "II. Motor dysfunction score of the lower extremities"
        case .sensation:
            return "III. Sensation"
        case .sphincter:
            return "IV. Sphincter dysfunction"
        }
    }
    
    var choices: [Choice] {
        switch self {
        case .motorHand:
            return Choice.motorHandChoices
        case .motorLeg:
            return Choice.motorHandChoices
        case .sensation:
            return Choice.sensationChoices
        case .sphincter:
            return Choice.sphincterChoices
        }
    }
    
}
