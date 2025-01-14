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

struct ButtonModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.title)
      .accentColor(Color.white)
      .padding()
  }
}

struct ShadowModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .shadow(color:Color("ColorBlackTransparent"), radius: 7)
    }
}



struct scoreNumberStyle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.system(size: 20, weight: .heavy, design: .rounded))
    }
}

struct scoreLabelStyle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.white)
            .font(.system(size: 10, weight: .bold, design: .rounded))
    }
}

struct scoreCapsuleStyle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
            .background(
                Capsule()
                    .foregroundColor(Color("ColorBlackTransparent")))
    }
}

struct ReelImageModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .frame(minWidth: 140, idealWidth: 200, maxWidth: 220, alignment: .center)
            .modifier(ShadowModifier())
    }
}

struct IconImageModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .frame(minWidth: 40, idealWidth: 60, maxWidth: 80, alignment: .center)
            .modifier(ShadowModifier())
    }
}


struct BetCapsuleModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.system(size: 25, weight: .heavy, design: .rounded))
            .modifier(ShadowModifier())
            .background(
                Capsule().fill(LinearGradient(gradient: Gradient(colors: [Color("ColorYellowRMIT"), Color("ColorRedRMIT")]), startPoint: .bottom, endPoint: .top))
                    .frame(width: 80, height: 50, alignment: .center)
            )
    }
}

struct CasinoChipModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .frame(height: 70)
            .modifier(ShadowModifier())
    }
}
