//
//  QuranOnlineApp.swift
//  QuranOnline
//
//  Created by Achmad Rifqi on 01/04/22.
//

import SwiftUI

@main
struct QuranOnlineApp: App {
    var objEnv = ApiServices()
    var body: some Scene {
        WindowGroup {
            SplashScreen().environmentObject(objEnv).environment(\.colorScheme, .light)
        }
    }
}
