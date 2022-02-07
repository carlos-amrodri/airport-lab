//
//  HomeRouter.swift
//  AirportAlboLab
//
//  Created by Carlos Rodriguez on 03/02/2022.
//

import Foundation
import UIKit
import SwiftUI

typealias EntryPoint = HomeViewProtocol & UIViewController

protocol HomeRouterProtocol {
    var entry : EntryPoint? { get }
    
    static func createModule() -> HomeRouterProtocol
    
    func navigateToMapsView(with viewController : UIViewController, radiusValue : Float)
}

class HomeRouter : HomeRouterProtocol {

    var entry : EntryPoint?
    
    static func createModule() -> HomeRouterProtocol {
        let router = HomeRouter()
        
        var view : HomeViewProtocol = HomeView()
        var presenter : HomePresenterProtocol = HomePresenter()
        var interactor : HomeInteractorProtocol = HomeInterctor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        router.entry = view as? EntryPoint
        
        return router
    }
    
    func navigateToMapsView(with viewController : UIViewController, radiusValue : Float){
        let contentView = MapRouter.createModule(with: Int(radiusValue))
        viewController.navigationController?.pushViewController(contentView, animated: true)
    }
    
}
