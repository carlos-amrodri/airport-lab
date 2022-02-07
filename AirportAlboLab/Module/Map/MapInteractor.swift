//
//  MapInteractor.swift
//  AirportAlboLab
//
//  Created by Carlos Rodrigez on 06/02/2022.
//

import Foundation
import Combine
import MapKit

protocol MapInteractorOuputProtocol {
    func didLoadPointAnnotation(points : [MKPointAnnotation])
}


class MapInteractor   {
    
    private var dataProvider : MapExternalDataProtocol
    
    var ouput : MapInteractorOuputProtocol?
    
    init( provider : MapExternalDataProtocol) {
        self.dataProvider = provider
        self.dataProvider.ouput = self
    }
    
    func updateAirpotsData(with location : LocationAndRadius){
        dataProvider.updateAirports(with: location)
    }
}

extension MapInteractor : MapExternalDataProtocolOuput  {
    
    func didLoadOirports(airports: Airports) {
        var arrayPoint : [MKPointAnnotation] = []
        airports.items.forEach { port in
            let point = MKPointAnnotation()
            let coordinate = CLLocationCoordinate2D(latitude: port.location.lat, longitude: port.location.lon)
            point.coordinate = coordinate
            point.title = port.name
            arrayPoint.append(point)
        }
        self.ouput?.didLoadPointAnnotation(points: arrayPoint)
    }
    
    
}
