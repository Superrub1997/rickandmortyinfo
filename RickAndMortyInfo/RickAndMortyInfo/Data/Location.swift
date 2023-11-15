//
//  Location.swift
//  RickAndMortyInfo
//
//  Created by MISO on 8/11/23.
//

import Foundation
struct Location : Codable {
    var id : Int
    var name : String
    var type : String
    var dimension : String
    var residents : [String]
    var url : String
}
