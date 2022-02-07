//
//  MapPresenter.swift
//  AirportAlboLab
//
//  Created by Carlos Rodrigez on 05/02/2022.
//

import Foundation
import Combine
import MapKit



class MapPresenter : ObservableObject {
    
    
    private var interactor : MapInteractor
    
    var radius : Int
    
    @Published var airportListPoint: [MKPointAnnotation] = []
    @Published var airportList: [AirportIdentif] = []

    
    init(radius : Int, interactor : MapInteractor){
        self.radius = radius
        self.interactor = interactor
        self.interactor.ouput = self
    }
    

    
    func getAirports(_ lat : Double, lon: Double){
        let location = LocationAndRadius(location: Location(lat: lat, lon: lon), radius: self.radius)
        interactor.updateAirpotsData(with: location)
    }
    
}

extension MapPresenter : MapInteractorOuputProtocol{
    
    func didLoadPointAnnotation(points: [MKPointAnnotation], airports: [Airport]) {
        DispatchQueue.main.async {
            self.airportListPoint = points
            self.airportList = airports.map({ airport in
                return AirportIdentif(airport: airport)
            })
        }
    }
    
    
    
}
