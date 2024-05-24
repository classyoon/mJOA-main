//
//  Choice.swift
//  mJOA
//
//  Created by Tim Yoon on 5/23/24.
//

import Foundation

struct Choice : Hashable {
    let text: String
    var value: Int
    
    static let motorHandChoices: [Choice] = [
        Choice(text: "Inability to move hands", value: 0),
        Choice(text: "Inability to eat with a spoon but able to move hands", value: 1),
        Choice(text: "Inability to button shirt but able to eat with a spoon", value: 2),
        Choice(text: "Able to button shirt with great difficulty", value: 3),
        Choice(text: "Able to button shirt with slight difficulty", value: 4),
        Choice(text: "No dysfunction", value: 5),
        
    ]
    
    static let motorLegChoices: [Choice] = [
        Choice(text: "Complete loss of motor and sensory function", value: 0),
        Choice(text: "Sensory preservation without ability to move legs", value: 1),
        Choice(text: "Able to move legs but unable to walk", value: 2),
        Choice(text: "Able to walk on flat floor with a walking aid (i.e., cane or crutch)", value: 3),
        Choice(text: "Able to walk up and/or down stairs with hand rail", value: 4),
        Choice(text: "Moderate to significant lack of stability but able to walk up and/or down stairs without hand rail", value: 5),
        Choice(text: "Mild lack of stability but walk unaided with smooth reciprocation", value: 6),
        Choice(text: "No dysfunction", value: 7),
    ]
    
    static let sensationChoices: [Choice] = [
        Choice(text: "Complete loss of hand sensation", value: 0),
        Choice(text: "Severe sensory loss or pain", value: 1),
        Choice(text: "Mild sensory loss", value: 2),
        Choice(text: "No sensory loss", value: 3),
    ]
    
    static let sphincterChoices: [Choice] = [
        Choice(text: "Inability to urinate voluntarily", value: 0),
        Choice(text: "Marked difficulty with micturition", value: 1),
        Choice(text: "Mild to moderate difficulty with micturition", value: 2),
        Choice(text: "Normal micturition", value: 3),
    ]
}
