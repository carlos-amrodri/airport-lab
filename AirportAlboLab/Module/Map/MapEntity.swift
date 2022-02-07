//
//  MapEntity.swift
//  AirportAlboLab
//
//  Created by Carlos Rodrigez on 05/02/2022.
//

import Foundation

struct Airports : Codable {
     
    var items : [Airport]
    
}

struct Airport : Codable {
    var name : String
    var icao : String
    var iata : String
    var shortName : String
    var location : Location
}

struct AirportIdentif : Identifiable {
    var id = UUID()
    var airport : Airport
}


struct Location : Codable {
    var lat : Double
    var lon : Double
}

struct LocationAndRadius {
    var location : Location
    var radius : Int
}
