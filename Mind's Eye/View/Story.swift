//  Name.swift
//  Mind's Eye
//
//  Created by Bashayer on 12/12/2024.

import SwiftUI
import AVFoundation

class AudioPlayerManager: NSObject, ObservableObject, AVAudioPlayerDelegate {
    @Published var isPlaying = false
    @Published var isFinished = false
    var audioPlayer: AVAudioPlayer?

    func prepareAudio() {
        if let url = Bundle.main.url(forResource: "CrimeStory", withExtension: "MP3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.delegate = self
                audioPlayer?.prepareToPlay()
            } catch {
                print("Error loading audio file: \(error)")
            }
        }
    }

    func toggleAudio() {
        if isPlaying {
            audioPlayer?.pause()
        } else {
            audioPlayer?.play()
            isFinished = false
        }
        isPlaying.toggle()
    }

    func rewindAudio() {
        guard let player = audioPlayer else { return }
        player.currentTime = max(player.currentTime - 15, 0)
    }

    func forwardAudio() {
        guard let player = audioPlayer else { return }
        player.currentTime = min(player.currentTime + 15, player.duration)
    }

    func stopAudio() {
        audioPlayer?.stop()
        isPlaying = false
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        isFinished = true
        isPlaying = false
    }
}

struct Story: View {
    @StateObject private var audioManager = AudioPlayerManager()

    var body: some View {
        NavigationStack {
            ZStack {
                Image("Image")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .accessibilityLabel("Background Image")
                    .accessibilityHint("This is the background image of the story.")

                VStack(spacing: 45) {
                    Spacer()

                    Image("SImage")
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 260, height: 260)
                       // .accessibilityLabel("Crime Scene Photo")
                        //.accessibilityHint("This is a Crime Scene Photo.")
                        .overlay(
                            Circle()
                                .stroke(Color.red, lineWidth: 2)
                                .frame(width: 280, height: 280)
                        )
                        //.accessibilityLabel("Highlighted Circle")
                        //.accessibilityHint("This circle highlights the crime scene photo.")
                        .padding(.top, 90)
                    // Audio control buttons
                    HStack(spacing: 45) {
                        Button(action: {
                            audioManager.rewindAudio()
                        }) {
                            Image(systemName: "gobackward.15")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                        }
                        .accessibilityLabel("Rewind Button")
                        .accessibilityHint("Rewinds the audio by 15 seconds.")

                        Button(action: {
                            if audioManager.isFinished {
                                audioManager.prepareAudio()
                                audioManager.toggleAudio()
                            } else {
                                audioManager.toggleAudio()
                            }
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color(red: 0.647, green: 0.007, blue: 0.008))
                                    .frame(width: 75, height: 75)
                                    .overlay(
                                        Circle()
                                            .stroke(Color.red.opacity(0.6), lineWidth: 4)
                                            .blur(radius: 4)
                                    )
                                Image(systemName: audioManager.isFinished ? "arrow.counterclockwise" : (audioManager.isPlaying ? "pause.fill" : "play.fill"))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(Color.black)
                                
                            }
                        }
                        .accessibilityLabel(audioManager.isFinished ? "Restart Button" : (audioManager.isPlaying ? "Pause Button" : "Play Button"))
                        .accessibilityHint(audioManager.isFinished ? "Restarts the audio." : (audioManager.isPlaying ? "Pauses the audio." : "Plays the audio."))

                        Button(action: {
                            audioManager.forwardAudio()
                        }) {
                            Image(systemName: "goforward.15")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                        }
                        .accessibilityLabel("Forward Button")
                        .accessibilityHint("Forwards the audio by 15 seconds.")
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 30)

                    Spacer()

                    // NavigationLink
                    NavigationLink(destination: Name().onAppear {
                        audioManager.stopAudio()
                    }) {
                        Text("Next")
                            .font(.custom("Questv1-Bold", size: 25))
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 200, height: 50)
                            .background(Color.black)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                    }
                    .accessibilityLabel("Next Button")
                    .accessibilityHint("Navigates to the next screen.")
                    .padding(.bottom, 80)
                }
            }
            .onAppear {
                audioManager.prepareAudio()
            }
        }
    }
}

#Preview("Arabic") {
    Story()
        .environment(\.locale, Locale(identifier: "AR"))
}
