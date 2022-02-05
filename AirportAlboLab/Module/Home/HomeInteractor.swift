//
//  HomeInteractor.swift
//  AirportAlboLab
//
//  Created by Carlos Rodriguez on 03/02/2022.
//

import Foundation

protocol HomeInteractorProtocol {
    var presenter : HomePresenterProtocol? {get set}
    
    func getInitialSearchRadius()
    
}


class HomeInterctor: HomeInteractorProtocol {
    var presenter : HomePresenterProtocol?
    let baseRadius: Float = 60
    
    func getInitialSearchRadius(){
        let initialSearchRadius = SearchRadius(floatRadius: baseRadius)
        presenter?.didLoadInitialSearchRadius(radius: initialSearchRadius)
    }
    

}




