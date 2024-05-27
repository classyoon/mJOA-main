//
//  ModifiedJOAView.swift
//  mJOA
//
//  Created by Tim Yoon on 5/23/24.
//

import SwiftUI
import SwiftData
enum Status {
    case mild, moderate, severe
    init(value : Int){
        switch value {
        case 0...11:
            self = .severe
        case 12...14:
            self = .moderate
        default:
            self = .mild
        }
    }
    var text : String {
        switch self {
        case .mild :
            return "Mild"
        case .moderate :
            return "Moderate"
        case .severe :
            return "Severe"
        }
    }
}
struct ModifiedJOAView: View {
    @Bindable var mJOA: ModifiedJOA
    
    var body: some View {
        VStack(alignment: .leading) {
            Group{
                Text("Score: \(scoreText)")
                    .font(.title)
                Text("Diagnosis: \(diagnosis)")
                DatePicker("Date", selection: $mJOA.timestamp, displayedComponents: [.date])
            }.padding()
            Group{
                JOAQuestionView(value: $mJOA.motorHand, question: JOAQuestion.motorHand)
                JOAQuestionView(value: $mJOA.motorLeg, question: JOAQuestion.motorLeg)
                JOAQuestionView(value: $mJOA.sensation, question: JOAQuestion.sensation)
                JOAQuestionView(value: $mJOA.sphincter, question: JOAQuestion.sphincter)
            }.padding().background(.yellow.opacity(0.8))
        }
        .padding()
        .background(.blue.opacity(0.5))
        
    }
    
    var scoreText: String {
        guard let handScore = mJOA.motorHand,
              let legScore = mJOA.motorLeg,
              let sensation = mJOA.sensation,
              let sphincter = mJOA.sphincter else {
            return "Not completed"
        }
        return String(handScore + legScore + sensation + sphincter)
    }
    var diagnosis: String {
            guard let handScore = mJOA.motorHand,
                  let legScore = mJOA.motorLeg,
                  let sensation = mJOA.sensation,
                  let sphincter = mJOA.sphincter else {
                return "Not completed"
            }
            let totalScore = handScore + legScore + sensation + sphincter
            return Status(value: totalScore).text
        }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: ModifiedJOA.self, configurations: config)
    @State var modifiedJOA = ModifiedJOA()
    container.mainContext.insert(modifiedJOA)
    return ModifiedJOAView(mJOA: modifiedJOA)
}
/*
 Note, @model class uses bindable not binding, so no $
 */
