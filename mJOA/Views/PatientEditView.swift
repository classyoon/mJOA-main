//
//  PatientEditView.swift
//  mJOA
//
//  Created by Conner Yoon on 5/24/24.
//

import SwiftUI
import SwiftData
struct PatientEditView: View {
    @State var firstName : String = ""
    @State var lastName : String = ""
    @State var mrn : String = ""
    @State var newPatient : Patient?
    /*
     Since MJOA only accepts optional patients to intialize it, I had to make patient here as optional as well. However it crashes 
     */
    var body: some View {
        NavigationStack {
            List {
                TextField("Type First Name", text: $firstName)
                TextField("Type Last Name", text: $lastName)
                TextField("Type MRN", text: $mrn)
                NavigationLink {
                    ModifiedJOAView(mJOA: ModifiedJOA(patient: newPatient))
                } label: {
                    Text("Confirm")
                }
            }
        }
    }
}

#Preview {
    PatientEditView()
}
