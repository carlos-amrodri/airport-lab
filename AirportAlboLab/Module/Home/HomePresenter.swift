//
//  HomePresenter.swift
//  AirportAlboLab
//
//  Created by Carlos Rodriguez on 03/02/2022.
//

import Foundation
import UIKit

protocol HomePresenterProtocol {
    var router : HomeRouterProtocol? {get set}
    var interactor : HomeInteractorProtocol? {get set}
    var view : HomeViewProtocol? {get set}
    
    func getSliderValue()
    func changeRadius(with value : Float)
    func navigateToMapsView(with viewController : UIViewController)
    
    func didLoadInitialSearchRadius( radius : SearchRadius)
}

class HomePresenter: HomePresenterProtocol {
    
    var router: HomeRouterProtocol?
    var interactor: HomeInteractorProtocol?
    var view: HomeViewProtocol?
    
    private var currentSearchRadius : SearchRadius!
    
    init() {
        currentSearchRadius = SearchRadius(floatRadius: 0)
    }
    
    func getSliderValue(){
        interactor?.getInitialSearchRadius()
    }
    
    func changeRadius(with value : Float){
        currentSearchRadius.floatRadius = value
    }
    
    func didLoadInitialSearchRadius( radius : SearchRadius){
        self.currentSearchRadius.floatRadius = radius.floatRadius
        view?.setRadiusValue(with: radius.floatRadius)
    }
    
    func navigateToMapsView(with viewController : UIViewController){
        router?.navigateToMapsView(with: viewController)
    }
    
}
