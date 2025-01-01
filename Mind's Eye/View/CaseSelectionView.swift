
//import SwiftUI
//
//@main
//struct MindsEyeApp: App {
//    var body: some Scene {
//        WindowGroup {
//            MindEyeViewModel() // Starting point of your app
//        }
//    }
//}
import SwiftUI

struct CaseModel: Identifiable {
    let id = UUID()
    let title: String
    let hint: String
}

class CaseViewModel: ObservableObject {
    @Published var cases: [CaseModel] = [
        CaseModel(title: NSLocalizedString("Murder Case", comment: ""), hint: NSLocalizedString("CaseOneHint", comment: "")),
        CaseModel(title: NSLocalizedString("Disappearance Case", comment: ""), hint: NSLocalizedString("CaseTwoHint", comment: "")),
        CaseModel(title: NSLocalizedString("Theft Case", comment: ""), hint: NSLocalizedString("CaseThreeHint", comment: ""))
    ]
}

struct CaseSelectionView: View {
    @StateObject private var viewModel = CaseViewModel()
    @State private var selectedCaseIndex: Int? = nil  // Track the selected button
    @State private var navigateToStory = false // State for navigation
    @Environment(\.presentationMode) var presentationMode // Environment variable to dismiss the view
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("Image")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack(spacing: 45) {
                    Text(NSLocalizedString("Choose a Case", comment: ""))
                        .font(.custom("Questv1-Bold", size: 35))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .accessibilityLabel(NSLocalizedString("Choose a Case", comment: ""))
                        .accessibilityAddTraits(.isHeader)
                    
                    VStack(spacing: 20) {
                        ForEach(viewModel.cases.indices, id: \.self) { index in
                            if index == 0 {
                                NavigationLink(destination: Story(), isActive: $navigateToStory) {
                                    CaseButton(
                                        title: viewModel.cases[index].title,
                                        hint: viewModel.cases[index].hint,
                                        isSelected: selectedCaseIndex == index,
                                        onTap: {
                                            selectedCaseIndex = index
                                            navigateToStory = true // Trigger navigation to Story view
                                        }
                                    )
                                }
                            } else {
                                CaseButton(
                                    title: viewModel.cases[index].title,
                                    hint: viewModel.cases[index].hint,
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
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss() // Custom back button action
                    }) {
                        Image(systemName: "chevron.left") // Custom back icon
                            .foregroundColor(.white) // Set color to white
                            .accessibilityLabel("Back") // Add accessibility label
                            .accessibilityHint("Go back to the previous screen") // Accessibility hint
                            .padding() // Add padding to make it easier to tap
                    }
                }
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
                .font(.custom("Questv1-Bold", size: 25))
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

struct Storys: View {
    var body: some View {
        Text("Story View")
            .font(.title)
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
