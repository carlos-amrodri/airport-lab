//
//  MapEntity.swift
//  AirportAlboLab
//
//  Created by Carlos Rodrigez on 05/02/2022.
//

import Foundation

struct Airports : Codable {
     
    var items : [airpot]
    
}

struct airpot : Codable {
    var name : String
    var icao : String
    var iata : String
    var shortName : String
}
