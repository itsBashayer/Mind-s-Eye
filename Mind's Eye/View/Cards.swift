import SwiftUI

struct Cards: View {
    @State private var userAnswers = [String]() // قائمة لتخزين إجابات المستخدم
    @State private var showSuccessPopup = false
    @State private var score = 0 // متغير لحساب النقاط

    let correctAnswers = ["key", "wound"]

    var body: some View {
        ZStack {
            Image("Image2")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack {
                Text("Collect Evidence")
                    .font(.custom("Questv1-Bold", size: 32))
                    .foregroundColor(.white)
                    .padding(.bottom, 40)
                    .shadow(color: .white, radius: 10, x: 0, y: 0)
                
                HStack(spacing: 20) {
                    EvidenceCard(evidence: "Key", isCorrect: userAnswers.contains("key"))
                    EvidenceCard(evidence: "Wound", isCorrect: userAnswers.contains("wound"))
                }
                
                VStack(spacing: 10) {
                    HStack {
                        Image(systemName: "mic.fill")
                            .foregroundColor(.white)
                            .padding(.leading, 10)
                        
                        TextField("Enter your answer", text: Binding(
                            get: { "" },
                            set: { newValue in
                                let answer = newValue.lowercased()
                                if correctAnswers.contains(answer) && !userAnswers.contains(answer) {
                                    userAnswers.append(answer)
                                    score = min(userAnswers.count, 3) // حساب النقاط بحد أقصى 3
                                }
                                if userAnswers.count == correctAnswers.count {
                                    showSuccessPopup = true
                                }
                            }))
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
                        if userAnswers.count == correctAnswers.count {
                            showSuccessPopup = true
                        }
                    }
                    .font(.custom("Questv1-Bold", size: 20))
                    .foregroundColor(.white)
                    .padding(.vertical, 5)
                }
                .padding()
            }

            // تأثير الضبابية الداكنة عند ظهور الـ popup
            if showSuccessPopup {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .transition(.opacity)

                VStack(spacing: 20) {
                    // شريط النقاط (streak) فوق البوب اب
                    Text("⭐ Score: \(score) / 3")
                        .font(.custom("Questv1-Bold", size: 24))
                        .foregroundColor(.yellow)
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(20)

                    CustomPopup(showSuccessPopup: $showSuccessPopup)
                    PopupButtons(showSuccessPopup: $showSuccessPopup)
                }
            }
        }
        .animation(.easeInOut, value: showSuccessPopup)
    }
}

struct EvidenceCard: View {
    let evidence: String
    let isCorrect: Bool
    
    @State private var flipped = false
    @State private var rotation = 180.0 // تبدأ مقلوبة
    
    var body: some View {
        ZStack {
            Group {
                if flipped {
                    // الوجه الأمامي - يظهر بعد الإجابة الصحيحة
                    Text(evidence)
                        .font(.custom("Questv1-Bold", size: 24))
                        .frame(width: 150, height: 200)
                        .background(Color.red)
                        .cornerRadius(20)
                        .foregroundColor(.white)
                } else {
                    // الوجه الخلفي - يظهر في البداية
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
            if isCorrect {
                flipCard()
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
                .shadow(color: Color.red.opacity(0.8), radius: 20, x: 0, y: 0)
        )
    }
}

struct PopupButtons: View {
    @Binding var showSuccessPopup: Bool

    var body: some View {
        VStack(spacing: 20) {
            Button("Go to the Next Level") {
                withAnimation {
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

            Button("Return to the Main Menu") {
                withAnimation {
                    showSuccessPopup = false
                }
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

struct Cards_Previews: PreviewProvider {
    static var previews: some View {
        Cards()
    }
}
