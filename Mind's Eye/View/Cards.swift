import SwiftUI

struct Cards: View {
    @State private var userAnswers = [String]()
    @State private var showSuccessPopup = false
    @State private var score = 0
    @State private var evidences = ["Key", "Wound"].shuffled()
    @State private var navigateToMainMenu = false
    @State private var currentInput = "" // النص المدخل في TextField

    let correctAnswers = ["key", "wound"]

    var body: some View {
        NavigationStack {
            ZStack {
                // Background image
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                VStack {
                    // Score bar
                    HStack {
                        Text("\(score) / \(correctAnswers.count)")
                            .font(.custom("Questv1-Bold", size: 24))
                            .foregroundColor(.red)
                            .padding(8)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white.opacity(0.8))
                                    .shadow(color: Color.red.opacity(0.6), radius: 4)
                            )
                            .padding(.leading)
                            .padding(.top, 40)
                        Spacer()
                    }
                    Spacer()
                }

                VStack {
                    Text("Collect Evidence")
                        .font(.custom("Questv1-Bold", size: 32))
                        .foregroundColor(.white)
                        .padding(.bottom, 40)
                        .shadow(color: .white, radius: 10, x: 0, y: 0)

                    HStack(spacing: 20) {
                        ForEach(evidences, id: \.self) { evidence in
                            EvidenceCard(
                                evidence: evidence,
                                isCorrect: userAnswers.contains(evidence.lowercased()),
                                onFlip: { flippedEvidence in
                                    if correctAnswers.contains(flippedEvidence.lowercased()) && !userAnswers.contains(flippedEvidence.lowercased()) {
                                        userAnswers.append(flippedEvidence.lowercased())
                                        score += 1
                                    }
                                    if userAnswers.count == correctAnswers.count {
                                        showSuccessPopup = true
                                    }
                                }
                            )
                        }
                    }

                    VStack(spacing: 10) {
                        HStack {
                            Image(systemName: "mic.fill")
                                .foregroundColor(.white)
                                .padding(.leading, 10)

                            TextField("Enter your answer", text: $currentInput)
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 5)
                        }
                        .background(Color(red: 0.1, green: 0, blue: 0))
                        .cornerRadius(25)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.white, lineWidth: 2)
                        )
                        .frame(width: 300)

                        Button("Send") {
                            let answer = currentInput.lowercased()
                            if correctAnswers.contains(answer) && !userAnswers.contains(answer) {
                                userAnswers.append(answer)
                                score += 1
                                currentInput = "" // إعادة تعيين النص
                            }
                            if userAnswers.count == correctAnswers.count {
                                showSuccessPopup = true
                            }
                        }
                        .font(.custom("Questv1-Bold", size: 20))
                        .foregroundColor(.white)
                        .padding(.vertical, 5)
                        .disabled(currentInput.isEmpty) // تعطيل الزر إذا كان النص فارغًا
                        .opacity(currentInput.isEmpty ? 0.5 : 1.0) // تغيير شفافية الزر
                    }
                    .padding()
                }

                if showSuccessPopup {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                        .transition(.opacity)

                    VStack(spacing: 20) {
                        Text("⭐ Score: \(score) / \(correctAnswers.count)")
                            .font(.custom("Questv1-Bold", size: 24))
                            .foregroundColor(.yellow)
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .cornerRadius(20)

                        CustomPopup(showSuccessPopup: $showSuccessPopup)

                        VStack(spacing: 20) {
                            Button("Go to the Next Level") {
                                withAnimation {
                                    userAnswers.removeAll()
                                    score = 0
                                    evidences.shuffle()
                                    showSuccessPopup = false
                                }
                            }
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.red)
                            .padding()
                            .frame(width: 350, height: 52)
                            .background(Color.white)
                            .cornerRadius(30)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.red, lineWidth: 2)
                            )

                            // Navigation to Main Menu
                            Button("Return to the Main Menu") {
                                navigateToMainMenu = true
                            }
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .padding()
                            .frame(width: 350, height: 52)
                            .background(Color.black)
                            .cornerRadius(30)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                        }
                        .padding(.top, 40)
                    }
                }
            }
            .navigationDestination(isPresented: $navigateToMainMenu) {
                CaseSelectionView()
            }
        }
        .animation(.easeInOut, value: showSuccessPopup)
    }
}

struct EvidenceCard: View {
    let evidence: String
    let isCorrect: Bool
    let onFlip: (String) -> Void

    @State private var flipped = false
    @State private var rotation = 180.0

    var body: some View {
        ZStack {
            Group {
                if flipped {
                    Text(evidence)
                        .font(.custom("Questv1-Bold", size: 24))
                        .frame(width: 150, height: 200)
                        .background(Color.red)
                        .cornerRadius(20)
                        .foregroundColor(.white)
                } else {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.black)
                        .frame(width: 150, height: 200)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.white, lineWidth: 2)
                        )
                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                }
            }
            .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))
        }
        .onTapGesture {
            if !flipped {
                flipCard()
                onFlip(evidence)
            }
        }
    }

    func flipCard() {
        withAnimation(.easeInOut(duration: 0.6)) {
            rotation += 180
            flipped.toggle()
        }
    }
}

struct CustomPopup: View {
    @Binding var showSuccessPopup: Bool

    var body: some View {
        VStack(spacing: 20) {
            Text("Good job!")
                .font(.custom("Questv1-Bold", size: 32))
                .fontWeight(.bold)
                .foregroundColor(.white)
            Text("You solved the case successfully!")
                .font(.custom("Questv1-Bold", size: 20))
                .foregroundColor(.white)
            Image("hammer")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
        }
        .frame(width: 350, height: 350)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.black)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white, lineWidth: 2)
                )
                .shadow(color: Color.red.opacity(0.4), radius: 20, x: 0, y: 0)
        )
    }
}



struct Cards_Previews: PreviewProvider {
    static var previews: some View {
        Cards()
    }
}
