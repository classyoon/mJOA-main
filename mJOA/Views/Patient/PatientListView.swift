//
//  PatientListView.swift
//  mJOA
//
//  Created by Conner Yoon on 5/24/24.
//

import SwiftUI
import SwiftData
import PhotosUI

extension Patient {
    static let examples : [Patient] = [Patient(firstName: "Jo", lastName: "Mama", mrn: "123"), Patient(firstName: "Mary", lastName: "Poppins", mrn: "987")]
    var fullName : String {
        return "\(firstName) \(lastName)"
    }
}


struct PatientListView: View {
    @Environment (\.modelContext) var modelContext
    @Query private var patients : [Patient]
    

    var body: some View {
        NavigationStack {
            List{
                ForEach(patients){ patient in
                    PatientItemView(patient: patient)
                }.onDelete(perform: { indexSet in
                    deleteItems(offsets: indexSet)
                })
            }
            .navigationTitle("Patients")
            .toolbar{
                EditButton()
                Button(action: {
                    addItem()
                }, label: {
                    Image(systemName: "plus")
                })
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Patient()
            modelContext.insert(newItem)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(patients[index])
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
    return NavigationStack{PatientListView().modelContainer(container)}
    
}

