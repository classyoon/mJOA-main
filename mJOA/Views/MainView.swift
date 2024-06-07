//
//  MainView.swift
//  mJOA
//
//  Created by Conner Yoon on 6/2/24.
//

import SwiftUI
import SwiftData

struct MainView: View {
    var body: some View {
        ZStack{
         
            TabView{
                Group{
//                    Rectangle().fill(.sunShine).overlay {
//                        Circle().foregroundStyle(.accent)
//                            .overlay{
//                                Rectangle().foregroundStyle(.tertiary).frame(width:100)
//                                
//                            }
//                            .overlay {
//                                VStack{
//                                    Capsule().foregroundStyle(Color(uiColor: UIColor.systemRed))
//                                        .frame(width: 100, height: 50)
//                                    Capsule().foregroundStyle(Color(uiColor: UIColor.red))
//                                        .frame(width: 100, height: 50)
//                                    Capsule().foregroundStyle(Color.red)
//                                        .frame(width: 100, height: 50)
//                                }
//                            }
//                
//                    }
                    PatientListView()
                        .tabItem { Label("Patients", systemImage:"person.2.fill") }
                        .toolbarBackground(.yellow,
                                           for: .navigationBar)
                        .toolbarBackground(.visible,
                                           for: .navigationBar)
                    ModifiedJOAListView().tabItem { Label("MJOA", systemImage:"list.clipboard.fill") }
                }
                            .toolbarBackground(.brown, for: .tabBar)
                                .toolbarBackground(.visible, for: .tabBar)
                                .toolbarColorScheme(.dark, for: .tabBar)
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
    return  MainView().modelContainer(container)
   
}
