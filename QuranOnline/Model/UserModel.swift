//
//  UserModel.swift
//  QuranOnline
//
//  Created by Achmad Rifqi on 04/04/22.
//

import Foundation
 
struct User  : Codable{
    var name : String
    var username : String
    var email : String
    var address : Address
    var phone : String
    var website : String
    var company : Company
    
    struct Address : Codable{
        var street : String
        var suite : String
        var city : String
        var zipcode : String
        
        
        struct Geo : Codable{
            var lat : String
            var lng : String
        }
    }
    
    struct Company : Codable{
        var name : String
        var catchPhrase : String
        var bs : String
    }
    
    
    
}
