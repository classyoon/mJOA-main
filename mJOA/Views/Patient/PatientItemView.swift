//
//  PatientItemView.swift
//  mJOA
//
//  Created by Conner Yoon on 6/4/24.
//

import SwiftUI

struct PatientItemView: View {
    var patient : Patient
    func compare(_ list : [ModifiedJOA])->String{
        ///MARK, Risky but should only be used when we are sure there is more than one.
        let recent = list[0].scoreText
        let second = list[1].scoreText
        
        //This sometimes just won't work.
        if recent > second {
            print("Improved")
            print("recent \(recent)")
            print("second \(second)")
            return "Improved"
        }
        if recent < second {
            print("Worsen")
            print("recent \(recent)")
            print("second \(second)")
            return "Worsen"
        }
        if recent == second {
            print("Same")
            print("recent \(recent)")
            print("second \(second)")
            return "Same Score"
        }
        return "compare function improperly used"
    }
    /**
     This will only compare the first two elements
     */
    func changeInStats(patient : Patient)->String{
        if let patientMJOAS = patient.mJOA {
            if patientMJOAS.isEmpty{
                return "No tests"
            }
            if patientMJOAS[patientMJOAS.count-1].scoreText == "Not completed" {
                return "Waiting"
            }
            if patientMJOAS.count == 1 {
                return patientMJOAS[0].scoreText
            }
            if patientMJOAS.count > 1 {
                return compare(patientMJOAS)
            }
        }
        return "Error Patient Missing MJOA"
        
    }
    var body: some View {
        NavigationLink {
            PatientEditView(patient: patient)
        }
    label: {
        HStack{
            ProfilePicView(person: patient, picSize: 50)
            VStack{
                Text("\(patient.firstName) \(patient.lastName) : \(patient.mrn)").font(.title)
                Text("\(changeInStats(patient: patient))")
            }
            
        }
    }
    }
}

#Preview {
    PatientItemView(patient: Patient.examples[0])
}
