//
//  PatientEditView.swift
//  mJOA
//
//  Created by Conner Yoon on 6/4/24.
//

import SwiftUI
import PhotosUI
struct PatientEditView : View {
    @Bindable var patient : Patient
    @State private var sourceType : SourceType?
    @State private var photosPickerItem : PhotosPickerItem?
    @State private var profileImage : Image?
    
    
    var body: some View {
        
        Form {
            PhotosPicker("Select avatar", selection: $photosPickerItem, matching: .images)
            
            ProfilePicView(person: patient, picSize: 200)
            TextField("First name", text: $patient.firstName)
            TextField("Last name", text: $patient.lastName)
            TextField("MRN", text: $patient.mrn)
            NavigationLink {
                
                MJOAListView(patient: patient, forPatientOnly: true)
                
            } label: {
                Text("MJOA List")
            }
            Button {
                sourceType = .camera
            } label: {
                Image(systemName: "camera.fill")
            }
            
            
        }
        .onChange(of: photosPickerItem) {
            Task {
                if let data = try? await photosPickerItem?.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        profileImage = Image(uiImage: uiImage)
                        patient.imageData = data
                        
                    }
                } else {
                    print("Failed")
                }
            }
        }.sensoryFeedback(.levelChange, trigger: patient.imageData)
            .sheet(item: $sourceType) { sourceType in
                CameraView(sourceType: sourceType, imageData: $patient.imageData)
            }
        
        
        
    }
}

#Preview {
    PatientEditView(patient: Patient.examples[0])
}
