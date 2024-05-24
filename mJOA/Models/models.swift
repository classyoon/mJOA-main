//
//  models.swift
//  mJOA
//
//  Created by Tim Yoon on 5/23/24.
//

import Foundation
import SwiftData

@Model class Patient {
    var firstName: String
    var lastName: String
    var mrn: String
    var mJOA: [ModifiedJOA]? = nil
    init(firstName: String = "", lastName: String = "", mrn: String = "", mJOA: [ModifiedJOA]? = nil) {
        self.firstName = firstName
        self.lastName = lastName
        self.mrn = mrn
        self.mJOA = mJOA
    }
}

@Model class ModifiedJOA {
    var patient: Patient?
    var timestamp: Date = Date()
    var motorHand: Int?
    var motorLeg: Int?
    var sensation: Int?
    var sphincter: Int?
    init(patient: Patient? = nil, timestamp: Date = Date(), motorHand: Int? = nil, motorLeg: Int? = nil, senssation: Int? = nil, sphincter: Int? = nil) {
        self.patient = patient
        self.motorHand = motorHand
        self.motorLeg = motorLeg
        self.sensation = senssation
        self.sphincter = sphincter
    }
}

extension ModifiedJOA {
    var scoreText: String {
        guard let handScore = motorHand,
              let legScore = motorLeg,
              let sensation = sensation,
              let sphincter = sphincter else {
            return "Not completed"
        }
        return String(handScore + legScore + sensation + sphincter)
    }
}

@Model class PatientList {
    var list : [Patient] = []
    init(list: [Patient]=[]) {
        self.list = list
    }
}
