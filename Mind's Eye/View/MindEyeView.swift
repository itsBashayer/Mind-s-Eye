import SwiftUI

struct MindEyeView: View {
    @State private var isNextViewActive = false

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
                    
                    
                    Text(NSLocalizedString("Every voice holds a secret, every guide leads a step", comment: "Main title"))
                        .font(.custom("Questv1-Bold", size: 25))
                        .foregroundColor(.white.opacity(0.8))
                        .accessibilityLabel("Description: Every voice holds a secret, every guide leads a step")
                        .padding(.top, 20)
                        .multilineTextAlignment(.center)

                    Spacer()

                    Button(action: {
                        isNextViewActive = true
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
                    .accessibilityLabel("Next")
                    .padding(.horizontal)
                    .padding(.bottom, 80)

                    NavigationLink(
                        destination: CaseSelectionView(),
                        isActive: $isNextViewActive,
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
        .environment(\.locale, Locale(identifier: "ar"))
}


