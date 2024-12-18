//
//  Name.swift
//  Mind's Eye
//
//  Created by Bashayer on 18/12/2024.
//


import SwiftUI

struct Name: View {
    @StateObject private var viewModel = CaseViewModel()
    @State private var selectedCaseIndex: Int? = nil
    @State private var navigateToStory = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("Image")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    Text("Who is the accused ")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .accessibilityLabel("Choose the Killer")
                        .accessibilityAddTraits(.isHeader)
                    
                    VStack(spacing: 20) {
                        ForEach(viewModel.cases.indices, id: \.self) { index in
                            if index == 0 {
                                NavigationLink(destination: Cards(), isActive: $navigateToStory) {
                                    CaseButton(
                                        title: "Ahmed",
                                        hint: viewModel.cases[index].hint,
                                        isSelected: selectedCaseIndex == index,
                                        onTap: {
                                            selectedCaseIndex = index
                                            navigateToStory = true
                                        }
                                    )
                                }
                            } else if index == 1 {
                                CaseButton(
                                    title: "Yusef",
                                    hint: viewModel.cases[index].hint,
                                    isSelected: selectedCaseIndex == index,
                                    onTap: {
                                        selectedCaseIndex = index
                                    }
                                )
                            } else if index == 2 {
                                CaseButton(
                                    title: "Salman",
                                    hint: viewModel.cases[index].hint,
                                    isSelected: selectedCaseIndex == index,
                                    onTap: {
                                        selectedCaseIndex = index
                                    }
                                )
                            }
                        }
                    }
                }
                .padding()
            }
        }
    }
}

struct CaseeButton: View {
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

struct Name_Previews: PreviewProvider {
    static var previews: some View {
        Name()
    }
}
