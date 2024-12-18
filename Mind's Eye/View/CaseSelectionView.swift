//
//  Untitled.swift
//  EYEGAMEAPP
//
//  Created by Malak on 18/12/2024.
//

import SwiftUI

struct CaseSelectionView: View {
    @StateObject private var viewModel = CaseViewModel()
    
    var body: some View {
        ZStack {
            
            Image("Image")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

                               
            VStack(spacing: 30) {
               
                Text("Choose a Case")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .accessibilityLabel("Choose a Case")
                    .accessibilityAddTraits(.isHeader)
                
                
                VStack(spacing: 20) {
                    ForEach(viewModel.cases) { caseItem in
                        CaseButton(title: caseItem.title, hint: caseItem.hint)
                    }
                }
            }
            .padding()
        }
    }
}


struct CaseButton: View {
    let title: String
    let hint: String
    
    var body: some View {
        Text(title)
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, minHeight: 60)
            .background(Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 12)) // Rounded corners
            .overlay(
                RoundedRectangle(cornerRadius: 50)
                    .stroke(Color.white, lineWidth: 2)
            )
            .padding(.horizontal, 30)
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(title)
            .accessibilityHint(hint)
            .accessibilityAddTraits(.isButton)
    }
}


struct CaseSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        CaseSelectionView()
    }
}
