//
//  PatientEditView.swift
//  mJOA
//
//  Created by Conner Yoon on 6/4/24.
//

import SwiftUI
import SwiftData
import PhotosUI
struct PatientEditView : View {
    @Bindable var patient : Patient
    @State private var sourceType : SourceType?
    @State private var photosPickerItem : PhotosPickerItem?
    @State private var profileImage : Image?
    @State private var editMode : Bool = false
    
    var body: some View {
        VStack{
            HStack{
                
                ProfilePicView(person: patient, picSize: 200)
                VStack{
                    Button {
                        editMode.toggle()
                    } label: {
                        Text("Edit")
                    }.buttonBorderShape(.automatic)
                    if editMode == true {
                        VStack(spacing:10){
                            Button {
                                sourceType = .camera
                            } label: {
                                Image(systemName: "camera.fill").resizable().frame(width: 50, height: 50)
                            }.buttonStyle(PlainButtonStyle())
                            PhotosPicker("Choose Photo", selection: $photosPickerItem, matching: .images)
                        }
                    }
                    
                }
            }
            
            
            if editMode == true {
                VStack{
                    TextField("First name", text: $patient.firstName)
                    TextField("Last name", text: $patient.lastName)
                    TextField("MRN", text: $patient.mrn)
                }.padding()
            } else{
               // Text("\(patient.firstName) \(patient.lastName)").font(.title)
                Text("MRN : \(patient.mrn)").font(.title)
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
            PatientMjoaListView(patient: patient, forPatientOnly: true)
            .background(Color.blue)
        }
    
    }

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Patient.self, configurations: config)
    Patient.examples.forEach { patient in
        container.mainContext.insert(patient)
    }
    return PatientEditView(patient: Patient.examples[0]).modelContainer(container)
}
