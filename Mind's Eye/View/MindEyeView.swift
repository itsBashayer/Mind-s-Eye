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
                    
                    Text(viewModel.title)
                        .font(.system(size: 45))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .accessibilityLabel("Title: Mind's Eye")
                        .padding(.top, 320)

                    Text(viewModel.subtitle)
                        .font(.system(size: 20))
                        .foregroundColor(.white.opacity(0.8))
                        .accessibilityLabel(" Description: every sound is a secrect, every evidence is a step froward ")
                        .padding(.top, 2)
                        .multilineTextAlignment(.center)

                    Spacer()

                    Button(action: {
                        viewModel.navigateToNext()
                    }) {
                        Text(viewModel.buttonText)
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
                    .accessibilityLabel( " Next button ")
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

struct CaseSelectionViewww_Previews: PreviewProvider {
    static var previews: some View {
        MindEyeView()
    }
}

