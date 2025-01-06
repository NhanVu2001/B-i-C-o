//
//  Bai_CaoApp.swift
//  Bai Cao
//
//  Created by Nhan Vu Thien on 28/08/2022.
//

import SwiftUI

@main
struct Bai_CaoApp: App {
    @StateObject var audioManager = AudioManager()
    
    var body: some Scene {
        WindowGroup {
            LandingPageView()
                .previewInterfaceOrientation(.portrait)
                .environmentObject(audioManager)
        }
    }
}
