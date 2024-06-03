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
        TabView{
            Group{
                PatientListView().tabItem { Label("Patients", systemImage:"person.2.fill") }
                ModifiedJOAListView().tabItem { Label("MJOA", systemImage:"list.clipboard.fill") }
            }
        }
    }
}

#Preview {
    MainView()
}
