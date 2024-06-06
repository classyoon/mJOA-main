//
//  PatientMjoaListView.swift
//  mJOA
//
//  Created by Conner Yoon on 6/4/24.
//

import SwiftUI
import SwiftData
struct PatientMjoaListView : View {
    @Environment (\.modelContext) var modelContext
    @Query private var mJOAs : [ModifiedJOA]
    let patient : Patient
    var forPatientOnly : Bool
    var filteredList : [ModifiedJOA] {
        return mJOAs.filter { mjoa in
            mjoa.patient == patient
        }
    }
    var body: some View {
       
        List {
            ForEach(forPatientOnly ?  filteredList : mJOAs) { joa in
                MJOAItemView(joa: joa)
                
            }.onDelete(perform: deleteItems).sensoryFeedback(.decrease, trigger: mJOAs)
        }
        .navigationTitle(patient.fullName)
        .toolbar {
            EditButton()
            Button(action: {
                addItem()
            }, label: {
                Image(systemName: "plus")
            }).sensoryFeedback(.increase, trigger: mJOAs)
        }
    }
    private func addItem() {
        withAnimation {
            let newItem = ModifiedJOA()
            newItem.patient = patient
            modelContext.insert(newItem)
            
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(mJOAs[index])
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
    return NavigationStack{PatientMjoaListView(patient: Patient.examples[0], forPatientOnly: true)}.modelContainer(container)
}
