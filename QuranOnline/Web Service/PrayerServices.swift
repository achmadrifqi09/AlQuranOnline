//
//  PrayerServices.swift
//  QuranOnline
//
//  Created by Achmad Rifqi on 08/04/22.
//

import Foundation


class PrayerServices : ObservableObject {
    @Published var prayerData : [Items] = []
    @Published var location : String = "Jakarta"
    @Published var isLoading  = true
    
   func getPrayerTime(){
        
        guard let url = URL(string: "https://muslimsalat.com/\(location).json?key=bc2f2bba711f74e1e342eb7cfba0d459")else{
            fatalError("FATAL ERROR")
        }
        
        let urlRequest = URLRequest(url: url)
        
       
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            guard let response = response as? HTTPURLResponse else{
                return
            }
            if response.statusCode == 200{
                
                guard let data = data else {
                    return
                }
               
                DispatchQueue.main.async {
                    do{
                        
                        let prayerDecode = try JSONDecoder().decode(PrayerModel.self, from: data)
                        self.prayerData = prayerDecode.items
                        self.isLoading = false
                    }catch{
                        print("Error : ", error)
                    }
                }
            }
            
        }.resume()
        
    }
}
