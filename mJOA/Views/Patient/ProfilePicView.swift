//
//  ProfilePicView.swift
//  mJOA
//
//  Created by Conner Yoon on 6/4/24.
//

import SwiftUI

import PhotosUI
struct ProfilePicView :View {
    var person : Patient
    var picSize : CGFloat
    var body: some View {
        if let data = person.imageData, let uiImage = UIImage(data: data){
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
                .frame(width: picSize, height: picSize)
                .clipShape(Circle())
        }
        else {
            Image(systemName: "person")
                .resizable()
                .scaledToFill()
                .frame(width: picSize, height: picSize)
                .clipShape(Circle())
        }
    }
    
}

#Preview {
    ProfilePicView(person: Patient.examples[0], picSize: 100)
}
