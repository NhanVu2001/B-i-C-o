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

struct HowToPlayView: View {
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    @Environment(\.dismiss) var dismiss
    //MARK: BODY
    var body: some View {
        ZStack{
            //Background and game logo at the top
            Image("Background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
            VStack{
                Image("LogoBaiCao")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 200, alignment: .center)
                //Form view and game rules
                Form {
                    Section(header: Text("How To Play")) {
                        Text("Click the Deal button to start playing, each turn cost 50$.")
                        Text("The cards Ace to 9 has values of 1 to 9.")
                        Text("The cards 10 to King has no value.")
                        Text("You win when your hand's point is higher than dealer's hand's.")
                        Text("You can reset money and win streak by clicking the Reset button.")
                    }
                    //Application info dump
                    Section(header: Text("Application Information")) {
                        HStack {
                            Text("App Name")
                            Spacer()
                            Text("RMIT Casino")
                        }
                        HStack {
                            Text("Course")
                            Spacer()
                            Text("COSC2659")
                        }
                        HStack {
                            Text("Year Published")
                            Spacer()
                            Text("2022")
                        }
                        HStack {
                            Text("Location")
                            Spacer()
                            Text("Saigon South Campus")
                        }
                        HStack {
                            Text("Student")
                            Spacer()
                            Text("Vu Thien Nhan")
                        }
                    }
                }
            }.frame(width: width, height: height-50)
        }
    }
}

struct HowToPlay_Previews: PreviewProvider {
    static var previews: some View {
        HowToPlayView()
    }
}
