//
//  Untitled.swift
//  EYEGAMEAPP
//
//  Created by Malak on 18/12/2024.
//

import SwiftUI

struct MindEyeView: View {
    @ObservedObject var viewModel = MindEyeViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("Image")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                VStack {
                    
                    Text("MindEye")
                        .font(.custom("Questv1-Bold", size: 53))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .accessibilityLabel("MindEye")
                        .padding(.top, 320)

                    Text("Every voice holds a secrect, every guide leads a step")
                        .font(.custom("Questv1-Bold", size: 25))
                        .foregroundColor(.white.opacity(0.8))
                        .accessibilityLabel("Description: Every voice holds a secrect, every guide leads a step")
                        .padding(.top, 20)
                        .multilineTextAlignment(.center)

                    Spacer()

                    Button(action: {
                        viewModel.navigateToNext()
                    }) {
                        Text("Next")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.clear)
                            .overlay(
                                RoundedRectangle(cornerRadius: 40)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                        
                        
                    }
                    .accessibilityLabel( " Next ")
                    .padding(.horizontal)
                    .padding(.bottom, 80)

                    NavigationLink(
                        destination: CaseSelectionView(),
                        isActive: $viewModel.isNextViewActive,
                        label: { EmptyView() }
                    )
                }
                .padding()
            }
           
        }
    }
}

struct MindEyeView_Previews: PreviewProvider {
    static var previews: some View {
        MindEyeView()
    }
}
#Preview("Arabic") {
    MindEyeView()
        .environment(\.locale, Locale(identifier: "AR"))
}
