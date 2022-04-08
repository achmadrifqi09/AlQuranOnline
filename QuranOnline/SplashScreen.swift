//
//  SplashScreen.swift
//  QuranOnline
//
//  Created by Achmad Rifqi on 08/04/22.
//

import SwiftUI

struct SplashScreen: View {
    @State var isActive = false
    @State private var size = 0.9
    @State private var opacity = 0.5
    var body: some View {
        if isActive{
            ContentView()
        }else{
            ZStack{
                Color.white.ignoresSafeArea()
                VStack{
                    Image("logo")
                        .resizable()
                        .frame(width : 110, height: 130)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear{
                    withAnimation(.easeIn(duration : 1)){
                        self.size = 1
                        self.opacity = 1
                    }
                }
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline : .now() + 3.0){
                    self.isActive = true
                }
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
