//
//  PrayerView.swift
//  QuranOnline
//
//  Created by Achmad Rifqi on 08/04/22.
//

import SwiftUI

struct PrayerView: View {
    
    
    @StateObject var prayer = PrayerServices()
    @State var location = ""
    
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            NavigationView{
                VStack(alignment: .leading){
                    ZStack{
                        Rectangle()
                            .foregroundColor(Color("bgColor"))
                        HStack{
                            Image(systemName: "location.fill")
                                .foregroundColor(Color.gray)
                            TextField("\(prayer.location)", text: $location)
                                .padding(.leading, 8)
                            Button(action : {
                                prayer.location = self.location
                                prayer.getPrayerTime()
                            }){
                                Text("Pilih")
                                    .padding(.trailing, 8)
                                    .foregroundColor(Color("Color"))
                            }
                        }
                        .padding()
                    }
                    .frame(height : 45)
                    .cornerRadius(13)
                    .padding()
                    Spacer()
                    
                    ForEach(prayer.prayerData){
                        data in
                        ScrollView{
                            HStack(){
                                Text("Tanggal : \(data.date_for)")
                                    .font(.headline)
                                Spacer()
                            }
                            HStack{
                                Text("Subuh")
                                Spacer()
                                Text(data.fajr)
                            }
                            .padding()
                            .background(Color("bgColor"))
                            .cornerRadius(14)
                            HStack{
                                Text("Terbit")
                                Spacer()
                                Text(data.shurooq)
                            }
                            .padding()
                            .background(Color("bgColor"))
                            .cornerRadius(14)
                            HStack{
                                Text("Dzuhur")
                                Spacer()
                                Text(data.dhuhr)
                            }
                            .padding()
                            .background(Color("bgColor"))
                            .cornerRadius(14)
                            HStack{
                                Text("Ashr")
                                Spacer()
                                Text(data.asr)
                            }
                            .padding()
                            .background(Color("bgColor"))
                            .cornerRadius(14)
                            HStack{
                                Text("Maghrib")
                                Spacer()
                                Text(data.maghrib)
                            }
                            .padding()
                            .background(Color("bgColor"))
                            .cornerRadius(14)
                            HStack{
                                Text("Isya")
                                Spacer()
                                Text(data.isha)
                            }
                            .padding()
                            .background(Color("bgColor"))
                            .cornerRadius(14)
                        }.padding()
                        
                    }
                    
                }
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading){
                        Text("Jadwal Sholat")
                            .font(.title2)
                            .frame(width : 150)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationViewStyle(StackNavigationViewStyle())
                .onAppear{
                    prayer.getPrayerTime()
                }
            }
            if (prayer.isLoading){
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
    }
}

struct PrayerView_Previews: PreviewProvider {
    static var previews: some View {
        PrayerView()
    }
}



