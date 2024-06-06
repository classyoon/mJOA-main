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
    @Query private var joaList: [ModifiedJOA] //This how you get the data out of swift data. It may look like an array, but its actually an ordered list.
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(joaList) { joa in
                    MJOAItemView(joa: joa)
                }.onDelete(perform: deleteItems).sensoryFeedback(.decrease, trigger: joaList)

            }
            .navigationTitle("JOAs")
            .toolbar {
                EditButton()
                Button(action: {
                    addItem()
                }, label: {
                    Image(systemName: "plus").padding()
                }).sensoryFeedback(.increase, trigger: joaList)
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
            for index in offsets {
                modelContext.delete(joaList[index])
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
