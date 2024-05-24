//
//  JOAQuestionView.swift
//  mJOA
//
//  Created by Tim Yoon on 5/23/24.
//

import SwiftUI
import SwiftData

struct JOAQuestionView: View {
    @Binding var value: Int?
    let question: JOAQuestion
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(question.text)
                .font(.headline)
            Picker("Answers", selection: $value) {
                Text("Not Selected").tag(nil as Int?)
                Divider()
                ForEach(question.choices, id: \.self) { choice in
                    Text(choice.text).tag(choice.value as Int?)
                }
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: ModifiedJOA.self, configurations: config)
    @State var modifiedJOA = ModifiedJOA()
    container.mainContext.insert(modifiedJOA)
    return JOAQuestionView(value: $modifiedJOA.motorHand, question: JOAQuestion.motorHand)
}
/*
 State and binding. You need state before you can get binding.
 */
