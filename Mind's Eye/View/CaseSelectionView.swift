



import SwiftUI

struct CaseSelectionView: View {
    @State private var cases = [
        (title: NSLocalizedString("Murder Case", comment: ""), hint: NSLocalizedString("CaseOneHint", comment: "")),
        (title: NSLocalizedString("Disappearance Case", comment: ""), hint: NSLocalizedString("CaseTwoHint", comment: "")),
        (title: NSLocalizedString("Theft Case", comment: ""), hint: NSLocalizedString("CaseThreeHint", comment: ""))
    ]
    @State private var selectedCaseIndex: Int? = nil  // Track the selected button
    @State private var navigateToStory = false // State for navigation
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("Image")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    Text(NSLocalizedString("Choose a Case", comment: ""))
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .accessibilityLabel(NSLocalizedString("Choose a Case", comment: ""))
                        .accessibilityAddTraits(.isHeader)
                    
                    VStack(spacing: 20) {
                        ForEach(cases.indices, id: \.self) { index in
                            if index == 0 {
                                NavigationLink(destination: Story(), isActive: $navigateToStory) {
                                    CaseButton(
                                        title: cases[index].title,
                                        hint: cases[index].hint,
                                        isSelected: selectedCaseIndex == index,
                                        onTap: {
                                            selectedCaseIndex = index
                                            navigateToStory = true // Trigger navigation to Story view
                                        }
                                    )
                                }
                            } else {
                                CaseButton(
                                    title: cases[index].title,
                                    hint: cases[index].hint,
                                    isSelected: selectedCaseIndex == index,
                                    onTap: {
                                        selectedCaseIndex = index // Set the selected case index
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

struct CaseSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        CaseSelectionView()
    }
}


#Preview("Arabic") {
    CaseSelectionView()
        .environment(\.locale, Locale(identifier: "ar"))
}
