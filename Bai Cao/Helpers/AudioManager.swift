/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Vu Thien Nhan
  ID: Your student id (e.g. 1234567)
  Created  date: 22/08/2022
  Last modified: 29/08/2022
  Acknowledgement: https://github.com/raindas/TicTacToe.
*/

import Foundation
import AVKit

final class AudioManager: ObservableObject {
    @Published var soundOn = true
    
    let backgroundSound = "BGMusic"
    
    private var audioPlayer: AVAudioPlayer!
    private var buttonTapPlayer: AVAudioPlayer!
    
    private func loadSound(filename: String, type: String) {
        let sound = Bundle.main.path(forResource: filename, ofType: type)
        self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
    }
/*
 Function to set background music for game.
 I used this to prevent music from stopping
 when another sound is triggered to play.
*/
    public func playBackgroundSound() {
        if soundOn {
            loadSound(filename: backgroundSound, type: "mp3")
            self.audioPlayer.numberOfLoops = 10
            self.audioPlayer.play()
        }
        return
    }
    //Function to set to mute game sound is unused
    public func stopSound() {
        if soundOn {
            self.audioPlayer.stop()
        } else {
            self.audioPlayer.play()
        }
    }
}
