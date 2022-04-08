//
//  ContentView.swift
//  QuranOnline
//
//  Created by Achmad Rifqi on 01/04/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var data = ApiServices()
    
    init(){
        UITabBar.appearance().barTintColor = UIColor.white
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color("unselectedColor"))
        UINavigationBarAppearance().backgroundColor = UIColor.white
    }
    
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            TabView{
                HomeView()
                    .tabItem{
                        Image(systemName: "book.closed")
                        Text("Surah")
                    }
                PrayerView()
                    .tabItem{
                        Image(systemName: "calendar")
                        Text("Jadwal Sholat")
                    }
            }
            .accentColor(Color.gray)
            
        }
        
    }
}


struct Test : View{
    var body: some View{
        Text("Coming Soon").font(.largeTitle)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ApiServices())
    }
}
