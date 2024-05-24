//
//  ModifiedJOAView.swift
//  mJOA
//
//  Created by Tim Yoon on 5/23/24.
//

import SwiftUI
import SwiftData

struct ModifiedJOAView: View {
    @Bindable var mJOA: ModifiedJOA
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Score: \(scoreText)")
                .font(.title)
            DatePicker("Date", selection: $mJOA.timestamp, displayedComponents: [.date])
            JOAQuestionView(value: $mJOA.motorHand, question: JOAQuestion.motorHand)
            JOAQuestionView(value: $mJOA.motorLeg, question: JOAQuestion.motorLeg)
            JOAQuestionView(value: $mJOA.sensation, question: JOAQuestion.sensation)
            JOAQuestionView(value: $mJOA.sphincter, question: JOAQuestion.sphincter)
        }
        .padding(.horizontal)
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
