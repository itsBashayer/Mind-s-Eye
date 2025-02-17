import SwiftUI
import AVFoundation

struct Cards: View {
    @State private var userAnswers = [String]()
    @State private var showSuccessPopup = false
    @State private var score = 0
    @State private var totalScore = 4  // يبدأ من 0/4
    @State private var evidences = ["مفتاح", "جرح"].shuffled()
    @State private var navigateToMainMenu = false
    @State private var currentInput = ""
    @Environment(\.presentationMode) var presentationMode
    
    // الإجابات الصحيحة
    let correctAnswers = ["مفتاح", "جرح"]
    
    @State private var flippedStates: [String: Bool] = [
        "مفتاح": false,
        "جرح": false
    ]

    @State private var shakeStates: [String: Int] = [
        "مفتاح": 0,
        "جرح": 0
    ]
    // أُضيف: متغير للتحكم بالصوت
    @State private var audioPlayer: AVAudioPlayer?
    
    // أُضيف: دالة لتشغيل الصوت
    func playSound(soundName: String) {
        if let path = Bundle.main.path(forResource: soundName, ofType: "mp3") {
            let url = URL(fileURLWithPath: path)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                print("Could not play the sound file: \(error)")
            }
        } else {
            print("Sound file not found: \(soundName).mp3")
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                // خلفية التطبيق
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                // ركن النتائج
                HStack {
                    ZStack {
                        Image("streak")
                            .resizable()
                            .frame(width: 82, height: 90)
                        
                        Text(String(format: NSLocalizedString("%d / %d", comment: "Score format: current score out of total score"), score, totalScore))
                            .font(.custom("Questv1-Bold", size: 16))
                            .foregroundColor(.black)
                            .frame(width: 50, height: 40, alignment: .center)
                            .accessibilityLabel(
                                String(format: NSLocalizedString("Score: %d out of %d", comment: "Accessibility label for score"), score, totalScore)
                            )
                            .offset(x: -2, y: 8)

                    }
                    .padding(8)
                    .padding(.leading, 310)
                    .padding(.top, -400)
                    
                    Spacer()
                }
                
                VStack {
                    
                    Text("Collect Evidence")
                        .font(.custom("Questv1-Bold", size: 32))
                        .foregroundColor(.white)
                        .padding(.bottom, 40)
                        .shadow(color: .white, radius: 10, x: 0, y: 0)
                    
                    // عرض الكروت
                    HStack(spacing: 20) {
                        ForEach(evidences, id: \.self) { evidence in
                            EvidenceCard(
                                evidence: evidence,
                                flipped: flippedStates[evidence.lowercased()] ?? false,
                                shakeCount: shakeStates[evidence.lowercased()] ?? 0
                            )
                        }
                    }
                    
                    // حقل الإدخال وزر "Send"
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
                            let answer = currentInput.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
                            print("Input Answer: \(answer)")
                            currentInput = ""

                            // Debugging state before logic
                            print("Current flippedStates: \(flippedStates)")
                            print("Current shakeStates: \(shakeStates)")
                            print("User Answers: \(userAnswers)")

                            if correctAnswers.contains(answer), !userAnswers.contains(answer) {
                                flippedStates[answer] = true
                                userAnswers.append(answer)
                                print("Correct answer. Flipping \(answer).")
                                playSound(soundName: "sonic-coin-sound")
                                if userAnswers.count == correctAnswers.count {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                        if score < totalScore {
                                            score += 1
                                        }
                                        evidences.shuffle()
                                        withAnimation {
                                            showSuccessPopup = true
                                        }
                                    }
                                }
                            } else {
                                let unflippedEvidences = evidences.filter {
                                    flippedStates[$0.lowercased()] == false
                                }
                                print("Unflipped Evidences: \(unflippedEvidences)")

                                if let randomCard = unflippedEvidences.randomElement() {
                                    let key = randomCard.lowercased()
                                    shakeStates[key, default: 0] += 1
                                    print("Shaking card: \(key)")
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
                
                // بوب أب النجاح
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
                                Button("Go to the Next Level") {
                                    withAnimation {
                                        // إعادة الضبط
                                        userAnswers.removeAll()
                                        flippedStates = ["مفتاح": false, "جرح": false]
                                        shakeStates = ["مفتاح": 0, "جرح": 0]
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
                                
                                Button("Return to the Main Menu") {
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
        // أنيميشن لظهور وإخفاء الـ Popup
        .animation(.easeInOut, value: showSuccessPopup)
    }
}

// MARK: - EvidenceCard
struct EvidenceCard: View {
    let evidence: String
    let flipped: Bool
    let shakeCount: Int  // عدد مرات الاهتزاز
    
    var body: some View {
        ZStack {
            // الوجه الخلفي (عند flipped = false)
            
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.black)
                .frame(width: 150, height: 200)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white, lineWidth: 2)
                )
                .opacity(flipped ? 0.0 : 1.0)
                .rotation3DEffect(.degrees(flipped ? 180 : 0),
                                  axis: (x: 0, y: 1, z: 0))

            // الوجه الأمامي (عند flipped = true)
            Text(evidence)
                .font(.custom("Questv1-Bold", size: 24))
                .frame(width: 150, height: 200)
                .background(Color.red)
                .cornerRadius(20)
                .foregroundColor(.white)
                .opacity(flipped ? 1.0 : 0.0)
                .rotation3DEffect(.degrees(flipped ? 0 : -180),
                                  axis: (x: 0, y: 1, z: 0))
        }
        // تأثير الاهتزاز
        .shake(animatableData: CGFloat(shakeCount))
        // أنيميشن القلب
        .animation(.easeInOut(duration: 0.6), value: flipped)
    }
}

// MARK: - ShakeEffect
struct ShakeEffect: GeometryEffect {
    var travelDistance: CGFloat = 10     // أقصى إزاحة يمينًا ويسارًا
    var shakesPerUnit: CGFloat = 3      // عدد الاهتزازات خلال الدورة
    var animatableData: CGFloat         // وسيط التحريك

    func effectValue(size: CGSize) -> ProjectionTransform {
        let translationX = travelDistance * sin(animatableData * .pi * shakesPerUnit)
        let transform = CGAffineTransform(translationX: translationX, y: 0)
        return ProjectionTransform(transform)
    }
}

extension View {
    func shake(animatableData: CGFloat) -> some View {
        self.modifier(ShakeEffect(animatableData: animatableData))
    }
}


// شاشة "القائمة الرئيسية" أو مستوى آخر

struct Cards_Previews: PreviewProvider {
    static var previews: some View {
        Cards()
    }
}



