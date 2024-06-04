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
    MainView()
}
