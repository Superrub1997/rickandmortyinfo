//
//  Character.swift
//  RickAndMortyInfo
//
//  Created by MISO on 8/11/23.
//

import Foundation
struct Character : Codable {
    var id : Int
    var name : String
    var status : String
    var species : String
    var type : String
    var gender : String
    var image : String
    var url : String
    var origin : nameAndUrl
    var location : nameAndUrl
    var episode : [String]
}

struct nameAndUrl : Codable {
    var name : String
    var url : String
}
