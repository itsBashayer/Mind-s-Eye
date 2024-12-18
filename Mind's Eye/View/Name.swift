//
//  Name.swift
//  Mind's Eye
//
//  Created by maha on 17/06/1446 AH.
//


import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        ZStack {
        Image("11")
                    .resizable()
                    .scaledToFill()
                    .frame(width:412, height:100)
                    .edgesIgnoringSafeArea(.all)
        
            VStack {
                
                Button(action: {
                                  
                                }) {
                                    Image("00")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 85, height: 85)
                                        .padding(.top,-40)
                                        .padding(.leading,300)
                                }
    
                Text("Who is the accused?")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top,160)
                
                Spacer()
                
                Button(action: {

                }) {
                    Text("Ahmed")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(width: 330, height: 53)
                        .background(Color(red: 160/255, green: 23/255, blue: 31/255))
                        .foregroundColor(.white)
                        .cornerRadius(30)
                        .overlay(
                        RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.white, lineWidth: 1))
                        .padding(.bottom,20)
                
                }
                
                Button(action: {
                }) {
                    Text("Yusuf")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(width: 330, height: 53)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(30)
                        .overlay(
                        RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.white, lineWidth: 1))
                        .padding(.bottom,20)
                       
                }
                
                Button(action: {
                }) {
                    Text("Salman")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(width: 330, height: 53)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(30)
                        .overlay(
                        RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.white, lineWidth: 1))
                        .padding(.bottom,250)
                }
                
            }}
    }
        }
        
#Preview {
    SwiftUIView()
}
