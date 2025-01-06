/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Vu Thien Nhan
  ID: Your student id (e.g. 1234567)
  Created  date: 22/08/2022
  Last modified: 29/08/2022
  Acknowledgement: https://github.com/TomHuynhSG/RMIT-Casino.
*/

import SwiftUI

struct LandingPage: View {
    @EnvironmentObject var audioManager: AudioManager
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    //User name and input holder vars
    @Binding var userName: String
    @State private var input: String = ""
    //Game state vars
    @State var isPlaying = false
    @State var isHowToplay = false
    @State var isLeaderBoard = false
    @State var isMain = true
    //MARK: BODY
    var body: some View {
        //Default state for page
        ZStack{
            if isMain {
                ZStack {
                    //Background, welcome message and logo
                    Image("Background")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                        .scaledToFill()
                    VStack{
                        Text("WELCOME TO")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                        
                        Image("LogoBaiCao")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 200, alignment: .center)
                        //Input user name field
                        TextField("Enter your name", text: $input)
                            .foregroundColor(.black)
                            .disableAutocorrection(true)
                            .frame(width: 300, height: 50, alignment: .center)
                            .padding(.leading,20)
                            .background(Capsule().foregroundColor(.white))
                            .padding(20)
                        //Play button
                        ZStack{
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .fill(Color(red: 0.7705919147, green: 0.1937867403, blue: 0.1496810615))
                                .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(Color(red: 0.9469942451, green: 0.9170835018, blue: 0.8738509417), lineWidth: 3))
                                .frame(width: 150, height: 50)
                            Text("Play")
                                .fontWeight(.heavy)
                                .foregroundColor(Color.white)
                        }.onTapGesture {
                            userName = input
                            if(userName != "") {
                                UserDefaults.standard.set(input, forKey: "userName")
                            }
                            isMain.toggle()
                            isPlaying.toggle()
                        }
                        //How to play button
                        ZStack{
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .fill(Color(red: 0.7705919147, green: 0.1937867403, blue: 0.1496810615))
                                .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(Color(red: 0.9469942451, green: 0.9170835018, blue: 0.8738509417), lineWidth: 3))
                                .frame(width: 150, height: 50)
                            Text("How to Play")
                                .fontWeight(.heavy)
                                .foregroundColor(Color.white)
                        }
                        .onTapGesture {
                            isMain.toggle()
                            isHowToplay.toggle()
                        }
                        //Leaderboard button
                        ZStack{
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .fill(Color(red: 0.7705919147, green: 0.1937867403, blue: 0.1496810615))
                                .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(Color(red: 0.9469942451, green: 0.9170835018, blue: 0.8738509417), lineWidth: 3))
                                .frame(width: 150, height: 50)
                            Text("Leaderboard")
                                .fontWeight(.heavy)
                                .foregroundColor(Color.white)
                        }.onTapGesture {
                            isMain.toggle()
                            isLeaderBoard.toggle()
                        }
                    }
                }
            }
            //Playing state for changing to game view
            if isPlaying{
                ZStack{
                    GameView(userName: userName)
                    Image(systemName: "xmark.circle")
                        .font(.title)
                        .foregroundColor(.black)
                        .frame(width: width, height: height,alignment: .topLeading)
                        .padding(.leading,50)
                        .padding(.top,80)
                        .onTapGesture {
                            isMain.toggle()
                            isPlaying.toggle()
                        }
                }
            }
            //HowToPlay state to change to how to play view
            if isHowToplay{
                ZStack{
                    HowToPlayView()
                    Image(systemName: "xmark.circle")
                        .font(.title)
                        .foregroundColor(.black)
                        .frame(width: width, height: height,alignment: .topLeading)
                        .padding(.leading,50)
                        .onTapGesture {
                            isMain.toggle()
                            isHowToplay.toggle()
                        }
                }
            }
            //LeaderBoard state for changing to leaderboard view
            if isLeaderBoard{
                ZStack{
                    LeaderboardView()
                    Image(systemName: "xmark.circle")
                        .font(.title)
                        .foregroundColor(.black)
                        .frame(width: width, height: height,alignment: .topLeading)
                        .padding(.leading,50)
                        .onTapGesture {
                            isMain.toggle()
                            isLeaderBoard.toggle()
                        }
                }
                
            }
        }
        //Play music on every screen
        .onAppear() {
            audioManager.playBackgroundSound()
        }
    }
}

//struct LandingPage_Previews: PreviewProvider {
//    static var previews: some View {
//        LandingPage()
//    }
//}
