//
//  PatientListView.swift
//  mJOA
//
//  Created by Conner Yoon on 5/24/24.
//

import SwiftUI
import SwiftData

extension Patient {
    static let examples : [Patient] = [Patient(firstName: "Jo", lastName: "Mama", mrn: "123"), Patient(firstName: "Mary", lastName: "Poppins", mrn: "987")]
    var fullName : String {
        return "\(firstName) \(lastName)"
    }
}
struct PatientEditView : View {
    @Bindable var patient : Patient
    
    var body: some View {
        Form {
            TextField("First name", text: $patient.firstName)
            TextField("Last name", text: $patient.lastName)
            TextField("MRN", text: $patient.mrn)
            NavigationLink {
                PatientMJOAListView(patient: patient)
            } label: {
                Text("MJOA List")
            }
            
        }
    }
}
struct PatientMJOAListView : View {
    @Environment (\.modelContext) var modelContext
    @Query private var mJOAs : [ModifiedJOA]
    let patient : Patient
    var filteredList : [ModifiedJOA] {
        return mJOAs.filter { mjoa in
            mjoa.patient == patient
        }
    }
    var body: some View {
        
        List {
            ForEach(filteredList) { joa in
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
        .navigationTitle(patient.fullName)
        .toolbar {
            EditButton()
            Button(action: {
                addItem()
            }, label: {
                Image(systemName: "plus")
            })
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

struct PatientListView: View {
    @Environment (\.modelContext) var modelContext
    @Query private var patients : [Patient]
    
    func changeInStats(patient : Patient)->String{
        if let patientMJOAS = patient.mJOA {
            var listHasStuff = patientMJOAS.count > 0
            var listTwoStuff = patientMJOAS.count > 1
            
            if listTwoStuff {
                
                var recent = patientMJOAS[0]
                var second = patientMJOAS[1]
                
                print("zero index : \(recent.scoreText)\n one index : \(second.scoreText)")
                if recent.scoreText > second.scoreText{
                    return "Improving"
                }else if recent.scoreText < second.scoreText{
                    return "Worsening"
                }else if recent.scoreText == second.scoreText {
                    if recent.scoreText == "Not completed"{
                        return "Please complete"
                    }
                    return "Maintaing"
                }
            }
            if listHasStuff {
            
                var score = patientMJOAS[0].scoreText
                
                return score
            }else{
                return "None"
            }
        }
        return "Error Patient Missing MJOA"
        
    }
    var body: some View {
        NavigationStack {
            List{
                ForEach(patients){ patient in
                    NavigationLink {
                        PatientEditView(patient: patient)
                  
                        
                    }
                label: {
                    Text("\(patient.firstName) \(patient.lastName) : \(patient.mrn) : \(changeInStats(patient: patient))")
                
                }
                    
                    
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
    let container = try! ModelContainer(for: Patient.self, configurations: config)
    Patient.examples.forEach { patient in
        container.mainContext.insert(patient)
    }
    return NavigationStack{PatientListView().modelContainer(container)}
    
}

