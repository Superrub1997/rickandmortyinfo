//
//  Episode.swift
//  RickAndMortyInfo
//
//  Created by MISO on 8/11/23.
//

import Foundation
struct Episode : Codable {
    var id : Int
    var name : String
    var air_date : String
    var episode : String
    var characters : [String]
    var url : String
}
