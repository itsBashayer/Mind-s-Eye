//
//  Untitled.swift
//  EYEGAMEAPP
//
//  Created by Malak on 18/12/2024.
//

//
//  Untitled.swift
//  EYEGAMEAPP
//
//  Created by Malak on 18/12/2024.
//

import SwiftUI

struct CaseSelectionView: View {
    @StateObject private var viewModel = CaseViewModel()
    @State private var selectedCaseIndex: Int? = nil  // Track the selected button
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("Image")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    Text("Choose a Case")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .accessibilityLabel("Choose a Case")
                        .accessibilityAddTraits(.isHeader)
                    
                    VStack(spacing: 20) {
                        ForEach(viewModel.cases.indices, id: \.self) { index in
                            CaseButton(
                                title: viewModel.cases[index].title,
                                hint: viewModel.cases[index].hint,
                                isSelected: selectedCaseIndex == index,
                                onTap: {
                                    selectedCaseIndex = index  // Set the selected case index
                                }
                            )
                        }
                    }
                }
                .padding()
            }
        }
    }
}

struct CaseButton: View {
    let title: String
    let hint: String
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, minHeight: 60)
                .background(
                    isSelected ? Color.red : Color.black
                    
                )
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.white, lineWidth: 2)
                )
                .padding(.horizontal, 30)
                .accessibilityElement(children: .ignore)
                .accessibilityLabel(title)
                .accessibilityHint(hint)
                .accessibilityAddTraits(.isButton)
        }
    }
}

struct NextView: View {
    var body: some View {
        Text("You are on the next page!")
            .font(.title)
            .fontWeight(.bold)
            .padding()
    }
}

struct CaseSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        CaseSelectionView()
    }
}
