//
//  HomeView.swift
//  QuranOnline
//
//  Created by Achmad Rifqi on 04/04/22.
//

import SwiftUI
import AVKit
struct HomeView: View {
    @ObservedObject var dataSurah = ApiServices()
    var body: some View {
        NavigationView{
            ZStack{
                Color.white.ignoresSafeArea(.all)
                ScrollView(showsIndicators : false){
                    ForEach(dataSurah.surahData){
                        surah in
                        NavigationLink(destination : SurahDetail(number: surah.number,title: surah.englishName)){
                            HStack(spacing : 14){
                                Text("\(surah.number)")
                                    .foregroundColor(Color.white)
                                    .frame(width : 45, height: 45)
                                    .background(Color.gray)
                                    .clipShape(Circle())
                                VStack(alignment : .leading, spacing: 4){
                                    Text("\(surah.name)")
                                        .font(.headline)
                                        .foregroundColor(Color.black)
                                    Text("Surah \(surah.englishName)・\(surah.revelationType)")
                                        .foregroundColor(Color.gray)
                                        .font(.caption)
                                }
                                Spacer()
                                HStack{
                                    Text("\(surah.numberOfAyahs)").font(.callout)
                                    Text("ayat")
                                        .foregroundColor(Color.gray)
                                        .font(.callout)
                                }
                                .padding([.leading, .trailing], 14)
                                .padding([.top, .all], 6)
                                .background(Color("bgText"))
                                .cornerRadius(14)
                            }
                            .padding()
                            .background(Color("bgColor"))
                            .cornerRadius(20)
                        }
                    }
                }
                .padding([.leading, .trailing], 14)
                .navigationBarTitleDisplayMode(.inline)
                
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading){
                        Text("Daftar Surah")
                            .font(.title2)
                            .frame(width : 120)
                    }
                }
                
                if (dataSurah.isLoading){
                    VStack{
                        Indicator()
                        Text("Mohon tunggu ..")
                    }
                    .padding()
                    .background(Color("bgColor"))
                    .cornerRadius(14)
                    .shadow(color: Color.secondary.opacity(0.3), radius: 20)
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationViewStyle(StackNavigationViewStyle())
        }
        
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

class SoundManager : ObservableObject{
    @Published var audioPlayer : AVPlayer?
    @Published var isPlaying : Bool = false
    
    func playAudio(sound : String){
        if let urlAudio = URL(string: sound){
            self.audioPlayer = AVPlayer(url: urlAudio)
            self.audioPlayer?.play()
            self.isPlaying = true
            NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
            
        }
        
    }
    
    func pauseAudio(){
        self.audioPlayer?.pause()
        self.isPlaying = false
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification) {
        self.isPlaying = false
    }
    
}



struct SurahDetail : View{
    var number : Int
    var title : String
    @State var playButtonId : Int = 0
    @ObservedObject var surahFetch = SurahDetailServices()
    @ObservedObject private var soundManager = SoundManager()
    
    var body: some View{
        ZStack{
            Color.white.ignoresSafeArea(.all)
            VStack{
                ScrollView(showsIndicators : false){
                    
                    ForEach(surahFetch.surahDetail){data in
                        VStack{
                            VStack(alignment : .trailing){
                                HStack{
                                    Spacer()
                                    Text("\(data.text)")
                                        .foregroundColor(Color.black)
                                        .multilineTextAlignment(.trailing)
                                }
                                Button(action : {
                                    
                                    
                                    if (soundManager.isPlaying == true){
                                        soundManager.pauseAudio()
                                        
                                        if (playButtonId != data.id){
                                            soundManager.playAudio(sound: data.audio)
                                            self.playButtonId = data.id
                                        }
                                        
                                    }else{
                                        soundManager.playAudio(sound: data.audio)
                                        self.playButtonId = data.id
                                    }
                                    
                                    
                                }){
                                    
                                    if (data.id == playButtonId &&
                                        soundManager.isPlaying == true){
                                        HStack{
                                            Image(systemName: "pause.fill")
                                                .foregroundColor(Color.gray)
                                            Text("Audio")
                                                .foregroundColor(Color.gray)
                                        }
                                        .padding([.top, .bottom], 5)
                                        .padding([.leading, .trailing], 14)
                                        .background(Color("bgText"))
                                        .cornerRadius(4)
                                    }else{
                                        HStack{
                                            Image(systemName: "play.fill")
                                                .foregroundColor(Color.gray)
                                            Text("Audio")
                                                .foregroundColor(Color.gray)
                                        }
                                        .padding([.top, .bottom], 5)
                                        .padding([.leading, .trailing], 14)
                                        .background(Color("bgText"))
                                        .cornerRadius(4)
                                    }
                                    
                                    
                                }
                            }
                        }
                        .padding()
                        .background(Color("bgColor"))
                        .cornerRadius(20)
                        
                    }
                    
                }
                .padding([.leading, .trailing], 14)
            }
        }
        .onAppear{
            self.surahFetch.getSurah(surahId: self.number)
        }
        .navigationTitle(Text("\(self.title)"))
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct Indicator : UIViewRepresentable{
    
    
    func makeUIView(context: UIViewRepresentableContext<Indicator>) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = UIColor.lightGray
        return indicator
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        uiView.startAnimating()
    }
}
