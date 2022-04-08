//
//  PrayerModel.swift
//  QuranOnline
//
//  Created by Achmad Rifqi on 08/04/22.
//

import Foundation

struct PrayerModel : Codable{
    var items : [Items]
}

struct Items : Codable, Identifiable {

    var date_for : String
    var fajr : String
    var shurooq : String
    var dhuhr : String
    var asr : String
    var maghrib : String
    var isha : String
    var id : Int{0}
    
}
