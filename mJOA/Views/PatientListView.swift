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
    
    func compare(_ list : [ModifiedJOA])->String{
        ///MARK, Risky but should only be used when we are sure there is more than one.
        let recent = list[0].scoreText
        let second = list[1].scoreText
       

        if recent > second {
            print("Improved")
            print("recent \(recent)")
            print("second \(second)")
            return "Improved"
        }
        if recent < second {
            print("Worsen")
            print("recent \(recent)")
            print("second \(second)")
            return "Worsen"
        }
        if recent == second {
            print("Same")
            print("recent \(recent)")
            print("second \(second)")
            return "Same Score"
        }
        return "compare function improperly used"
    }
    /**
     This will only compare the first two elements
     */
    func changeInStats(patient : Patient)->String{
        if let patientMJOAS = patient.mJOA {
            if patientMJOAS.isEmpty{
                return "No tests"
            }
            if patientMJOAS[patientMJOAS.count-1].scoreText == "Not completed" {
                return "Waiting"
            }
            if patientMJOAS.count == 1 {
                return patientMJOAS[0].scoreText
            }
            if patientMJOAS.count > 1 {
                return compare(patientMJOAS)
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

