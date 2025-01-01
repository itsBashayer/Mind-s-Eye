//  Name.swift
//  Mind's Eye
//  Created by Bashayer on 18/12/2024.
//
import SwiftUI
import AVFoundation
import AudioToolbox

struct Name: View {
    @State private var selectedCaseIndex: Int? = nil
    @State private var navigateToStory = false
    @State private var audioPlayer: AVAudioPlayer?

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
                    Text(NSLocalizedString("Who is the accused?", comment: "Main title"))
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .accessibilityLabel(NSLocalizedString("Choose the accused", comment: "Accessibility label for main title"))
                        .accessibilityAddTraits(.isHeader)
                    
                    VStack(spacing: 20) {
                        ForEach(cases.indices, id: \.self) { index in
                            if index == 0 {
                                NavigationLink(
                                    destination: Cards(),
                                    isActive: $navigateToStory
                                ) {
                                    CaseSelectionButton(
                                        title: cases[index].0,
                                        hint: cases[index].1,
                                        isSelected: selectedCaseIndex == index
                                    )
                                }
                                .simultaneousGesture(TapGesture().onEnded {
                                    playButtonSound()
                                })
                            } else {
                                Button(action: {
                                    selectedCaseIndex = index
                                    vibrate()
                                }) {
                                    CaseSelectionButton(
                                        title: cases[index].0,
                                        hint: cases[index].1,
                                        isSelected: selectedCaseIndex == index
                                    )
                                }
                            }
                        }
                    }
                }
                .padding()
            }
        }
    }

    private func playButtonSound() {
        guard let soundURL = Bundle.main.url(forResource: "buttonsound", withExtension: "wav") else {
            print("صوت buttonsound.wav غير موجود")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.play()
        } catch {
            print("خطأ في تشغيل الصوت: \(error.localizedDescription)")
        }
    }

    private func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}

struct CaseSelectionButton: View {
    let title: String
    let hint: String
    let isSelected: Bool
    
    var body: some View {
        Text(title)
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, minHeight: 60)
            .background(isSelected ? Color.red : Color.black)
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
