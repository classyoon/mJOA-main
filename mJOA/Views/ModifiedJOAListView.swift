//
//  ModifiedJOAListView.swift
//  mJOA
//
//  Created by Tim Yoon on 5/23/24.
//

import SwiftUI
import SwiftData
/*
 This compiles.
 */

struct ModifiedJOAListView: View {
    @Environment(\.modelContext) private var modelContext//Where is the model context, in the enviroment. Important. Think of it as in RAM that interfaces to the persistent data store.
    var joaList: [ModifiedJOA] //I kept this because I was unsure whether it was key to the achitecture; however, in order for it to be made, it needed to be public.  I would prefer operating off patients though.
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(joaList) { joa in
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
            .navigationTitle(patientName)
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

    var patientName: String {
        if joaList.isEmpty || joaList[0].patient?.firstName == nil {
            return "No Name Given"
        }
        return joaList[0].patient!.firstName//This is messy but it gets a name from the patient in a way to compile.
    }
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(joaList[index])
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: ModifiedJOA.self, configurations: config)
    
    
    return ModifiedJOAListView(joaList: [ModifiedJOA()])
        .modelContainer(container)
}
