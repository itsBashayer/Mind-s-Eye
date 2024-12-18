
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

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        isFinished = true
        isPlaying = false
    }
    }

    struct Story: View {
    @StateObject private var audioManager = AudioPlayerManager()

  
    var body: some View {
       // NavigationView {
            ZStack {
                
                Image("backPIC")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    HStack {
                        Spacer()

                        
                        NavigationLink(destination: CaseSelectionView()) {
                            HStack {
                                Text("Next")
                                    .foregroundColor(.white)
                                    .font(.headline)
                                Image(systemName: "arrow.right")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(.white)
                            }
                        }
                        .padding()
                    }

                    Spacer()

                    
                    Image("SImage")
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 260, height: 260)
                        .overlay(
                            Circle()
                                .stroke(Color.red, lineWidth: 2)
                                .frame(width: 280, height: 280)
                        )

                    // all the button's
                    HStack(spacing: 20) {
                        // back
                        Button(action: {
                            audioManager.rewindAudio()
                        }) {
                            Image(systemName: "gobackward.15")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.white)
                        }

                        // Back/replay
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
                                    .frame(width: 60, height: 60) // CirSize
                                    .overlay(
                                        Circle()
                                            .stroke(Color.red.opacity(0.6), lineWidth: 4)
                                            .blur(radius: 4)
                                            .offset(x: 0, y: 0)
                                    ) // Shadow
                                Image(systemName: audioManager.isFinished ? "arrow.counterclockwise" : (audioManager.isPlaying ? "pause.fill" : "play.fill"))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(Color.black) //Start icon
                            }
                        }

                        //goforward B
                        Button(action: {
                            audioManager.forwardAudio()
                        }) {
                            Image(systemName: "goforward.15")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 30)

                    Spacer()
                }
            }
            .onAppear {
                audioManager.prepareAudio()
            }
       // }
    }
    }

    #Preview {
    Story()
    }
