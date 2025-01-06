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

struct LandingPageView: View {
    @State var userName: String = ""
    
    var body: some View {
        LandingPage(userName: $userName)
    }
}

struct LandingPageView_Previews: PreviewProvider {
    static var previews: some View {
        LandingPageView()
    }
}
