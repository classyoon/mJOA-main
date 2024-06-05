//
//  MJOAItemView.swift
//  mJOA
//
//  Created by Conner Yoon on 6/4/24.
//

import SwiftUI
import SwiftData
struct MJOAItemView: View {
    @State var joa : ModifiedJOA
    @Query private var patients : [Patient]
    var body: some View {
        
        NavigationLink {
            ModifiedJOAView(mJOA: joa)
        } label: {
            HStack {
                Text("\(joa.timestamp.formatted())")
                Spacer()
                Text("\(joa.scoreText)")
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Patient.self, ModifiedJOA.self, configurations: config)
    Patient.examples.forEach { patient in
        container.mainContext.insert(patient)
    }
    return MJOAItemView(joa: ModifiedJOA()).modelContainer(container)
}
