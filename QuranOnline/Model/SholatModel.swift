//
//  SholatModel.swift
//  QuranOnline
//
//  Created by Achmad Rifqi on 08/04/22.
//

import Foundation

struct SholatModel : Codable{
    var results : DateTime
}

struct DateTime : Codable{
    var datetime : [Times]
}

struct Times : Codable{
    var Imsak :String
    var Sunrise : String
    var Fajr : String
    var Dhuhr : String
    var Asr : String
    var Sunset : String
    var Maghrib : String
    var Isha : String
}
