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
                .background {
                    ZStack{
                        Circle().foregroundStyle(.background)
                        Circle().stroke(lineWidth: 1.0)
                    }
                }
                .shadow(radius: 4, x: 4, y: 4)
               
        }
        else {
            Image(.john)
                .resizable()
                .scaledToFill()
                .frame(width: picSize, height: picSize)
//                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 10)
                .clipShape(Circle())
//                .shadow(radius: 10)
                .background {
                    ZStack{
                        Circle().foregroundStyle(.background)
                        Circle().stroke(lineWidth: 1.0)
                            .shadow(radius: 6, x: 4, y: 4)
                    }
                    
                }
                
        }
    }
    
}

#Preview {
    ProfilePicView(person: Patient.examples[0], picSize: 200)
}
