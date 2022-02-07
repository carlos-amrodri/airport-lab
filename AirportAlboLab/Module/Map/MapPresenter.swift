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
    
    @Published var airportList: [MKPointAnnotation] = []

    
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
    func didLoadPointAnnotation(points: [MKPointAnnotation]) {
        DispatchQueue.main.async {
            self.airportList = points
        }
    }
    
    
}
