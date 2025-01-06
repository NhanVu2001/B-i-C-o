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

struct LeaderboardView: View {
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    // Array to store data
    @State private var highScores = UserDefaults.standard.array(forKey: "highScores") as? [Int] ?? [0,0,0,0,0,0,0,0,0,0]
    @State private var hsHolders = UserDefaults.standard.stringArray(forKey: "hsHolders") ?? ["","","","","","","","","",""]
    //MARK: BODY
    var body: some View {
        ZStack {
            //Background and game logo at the top
            Image("Background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
            VStack {
                Image("LogoBaiCao")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 200, alignment: .center)
                //Form view and each line view
                Form {
                    Section(header: Text("Leaderboard")) {
                        if (0<highScores.count) {
                            HStack {
                                Text(hsHolders[0])
                                Spacer()
                                Text("\(highScores[0])")
                            }
                        }
                        if (1<highScores.count) {
                            HStack {
                                Text(hsHolders[1])
                                Spacer()
                                Text("\(highScores[1])")
                            }
                        }
                        if (2<highScores.count) {
                            HStack {
                                Text(hsHolders[2])
                                Spacer()
                                Text("\(highScores[2])")
                            }
                        }
                        if (3<highScores.count) {
                            HStack {
                                Text(hsHolders[3])
                                Spacer()
                                Text("\(highScores[3])")
                            }
                        }
                        if (4<highScores.count) {
                            HStack {
                                Text(hsHolders[4])
                                Spacer()
                                Text("\(highScores[4])")
                            }
                        }
                        if (5<highScores.count) {
                            HStack {
                                Text(hsHolders[5])
                                Spacer()
                                Text("\(highScores[5])")
                            }
                        }
                        if (6<highScores.count) {
                            HStack {
                                Text(hsHolders[6])
                                Spacer()
                                Text("\(highScores[6])")
                            }
                        }
                        if (7<highScores.count) {
                            HStack {
                                Text(hsHolders[7])
                                Spacer()
                                Text("\(highScores[7])")
                            }
                        }
                        if (8<highScores.count) {
                            HStack {
                                Text(hsHolders[8])
                                Spacer()
                                Text("\(highScores[8])")
                            }
                        }
                        if (9<highScores.count) {
                            HStack {
                                Text(hsHolders[9])
                                Spacer()
                                Text("\(highScores[9])")
                            }
                        }
                    }
                }
            }.frame(width: width, height: height-50)
        }
    }
}

struct Leaderboard_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}
