import SwiftUI

struct Cards: View {
    @State private var userAnswers = [String]()
    @State private var showSuccessPopup = false
    @State private var score = 0
    @State private var totalScore = 4
    @State private var evidences = ["Key", "Wound"].shuffled()
    @State private var navigateToMainMenu = false
    @State private var currentInput = ""

    let correctAnswers = ["key", "wound"]

    var body: some View {
        NavigationStack {
            ZStack {
                // Background image
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                HStack {
                    ZStack {
                        Image("streak")
                            .resizable()
                            .frame(width: 62, height: 70)

                        Text("\(score) / \(totalScore)")
                            .font(.custom("Questv1-Bold", size: 16))
                            .foregroundColor(.black)
                            .frame(width: 50, height: 40, alignment: .center)
                            .offset(x: 4, y: 2)
                    }
                    .padding(8)
                    .padding(.leading)
                    .padding(.top, -400)

                    Spacer()
                }

                VStack {
                    Text("اجمع الأدلة")
                        .font(.custom("Questv1-Bold", size: 32))
                        .foregroundColor(.white)
                        .padding(.bottom, 40)
                        .shadow(color: .white, radius: 10, x: 0, y: 0)

                    HStack(spacing: 20) {
                        ForEach(evidences, id: \ .self) { evidence in
                            EvidenceCard(
                                evidence: evidence,
                                isCorrect: userAnswers.contains(evidence.lowercased()),
                                onFlip: { flippedEvidence in
                                    if correctAnswers.contains(flippedEvidence.lowercased()) && !userAnswers.contains(flippedEvidence.lowercased()) {
                                        userAnswers.append(flippedEvidence.lowercased())
                                    }
                                    if userAnswers.count == correctAnswers.count {
                                        userAnswers.removeAll()
                                        score = totalScore
                                        evidences.shuffle()
                                        if score >= totalScore {
                                            withAnimation {
                                                showSuccessPopup = true
                                            }
                                        }
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

                        Button("إرسال") {
                            let answer = currentInput.lowercased()
                            if correctAnswers.contains(answer) && !userAnswers.contains(answer) {
                                userAnswers.append(answer)
                                currentInput = ""
                            }
                            if userAnswers.count == correctAnswers.count {
                                userAnswers.removeAll()
                                score = totalScore
                                evidences.shuffle()
                                if score >= totalScore {
                                    withAnimation {
                                        showSuccessPopup = true
                                    }
                                }
                            }
                        }
                        .font(.custom("Questv1-Bold", size: 20))
                        .foregroundColor(.white)
                        .padding(.vertical, 35.0)
                        .disabled(currentInput.isEmpty)
                        .opacity(currentInput.isEmpty ? 0.5 : 1.0)
                    }
                    .padding()
                }

                if showSuccessPopup {
                    ZStack {
                        Color.black.opacity(0.5)
                            .ignoresSafeArea()
                            .transition(.opacity)

                        VStack(spacing: 20) {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.black)
                                .frame(width: 350, height: 300)
                                .overlay(
                                    VStack(spacing: 10) {
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
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.white, lineWidth: 2)
                                )
                                .shadow(color: Color.red.opacity(0.4), radius: 20, x: 0, y: 0)

                            VStack(spacing: 20) {
                                Button("الإنتقال للمرحلة التالية") {
                                    withAnimation {
                                        score = 0
                                        userAnswers.removeAll()
                                        evidences.shuffle()
                                        showSuccessPopup = false
                                    }
                                }
                                .font(.headline)
                                .fontWeight(.bold)
                                .padding(.vertical, 18.0)
                                .foregroundColor(Color.red)
                                .frame(width: 350, height: 52)
                                .background(Color.white)
                                .cornerRadius(30)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.red, lineWidth: 2)
                                )

                                Button("الرجوع للقائمة الرئيسية") {
                                    navigateToMainMenu = true
                                }
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .frame(width: 350, height: 52)
                                .background(Color.black)
                                .cornerRadius(30)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.white, lineWidth: 2)
                                )
                            }
                        }
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

struct Cards_Previews: PreviewProvider {
    static var previews: some View {
        Cards()
    }
}



