//
//  ModifiedJOAListView.swift
//  mJOA
//
//  Created by Tim Yoon on 5/23/24.
//

import SwiftUI
import SwiftData

struct ModifiedJOAListView: View {
    @Environment(\.modelContext) private var modelContext//Where is the model context, in the enviroment. Important. Think of it as in RAM that interfaces to the persistent data store.
    @Query private var patient: Patient //This how you get the data out of swift data. It may look like an array, but its actually an ordered list.
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(patient.mJOA ?? [ModifiedJOA(patient: patient)]) { joa in
                    NavigationLink {
                        ModifiedJOAView(mJOA: joa)
                    } label: {
                        VStack {
                            Text("\(joa.timestamp)")
                            Text("\(joa.scoreText)")
                        }
                    }
                }.onDelete(perform: deleteItems)
                
            }
            .navigationTitle("JOAs")
            .toolbar {
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
            let newItem = ModifiedJOA()
            modelContext.insert(newItem)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            
            guard let patientList = patient.mJOA else {
                for index in offsets {
                    modelContext.delete(patientList[index])
                }
            }
            
        }
        
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: ModifiedJOA.self, configurations: config)
    
    
    return ModifiedJOAListView()
        .modelContainer(container)
}
