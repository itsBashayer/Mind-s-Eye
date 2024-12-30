//
//  Name.swift
//  Mind's Eye
//
//  Created by Bashayer on 18/12/2024.
//
import SwiftUI

struct Name: View {
    @State private var selectedCaseIndex: Int? = nil
    @State private var navigateToStory = false

    // Localized strings for cases
    let cases = [
        (NSLocalizedString("Ahmed", comment: "Case name"), NSLocalizedString("The first suspect", comment: "Case hint")),
        (NSLocalizedString("Yusef", comment: "Case name"), NSLocalizedString("The second suspect", comment: "Case hint")),
        (NSLocalizedString("Salman", comment: "Case name"), NSLocalizedString("The third suspect", comment: "Case hint"))
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("Image2")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    // Main title
                    Text(NSLocalizedString("Who is the accused?", comment: "Main title"))
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .accessibilityLabel(NSLocalizedString("Choose the accused", comment: "Accessibility label for main title"))
                        .accessibilityAddTraits(.isHeader)
                    
                    VStack(spacing: 20) {
                        // Display buttons for each case
                        ForEach(cases.indices, id: \.self) { index in
                            NavigationLink(
                                destination: index == 0 ? Cards() : nil,
                                isActive: Binding(
                                    get: { selectedCaseIndex == index && navigateToStory },
                                    set: { newValue in
                                        if newValue {
                                            selectedCaseIndex = index
                                            navigateToStory = index == 0
                                        }
                                    }
                                )
                            ) {
                                CaseSelectionButton(
                                    title: cases[index].0,
                                    hint: cases[index].1,
                                    isSelected: selectedCaseIndex == index,
                                    onTap: {
                                        selectedCaseIndex = index
                                        if index == 0 {
                                            navigateToStory = true
                                        }
                                    }
                                )
                            }
                            .disabled(index != 0) // Disable navigation for non-first cases
                        }
                    }
                }
                .padding()
            }
        }
    }
}

struct CaseSelectionButton: View {
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
            .environment(\.locale, Locale(identifier: "en"))
            .environment(\.layoutDirection, .leftToRight)
    }
}
#Preview("Arabic") {
    Name()
        .environment(\.locale, Locale(identifier: "AR"))
}
