//
//  MapRouter.swift
//  AirportAlboLab
//
//  Created by Carlos Rodrigez on 06/02/2022.
//

import Foundation
import SwiftUI

protocol MapRouterProtocol {
    static func createModule(with radius : Int) -> UIHostingController<ContentMapsView>
}


class MapRouter :MapRouterProtocol {
    
    static func createModule(with radius : Int) -> UIHostingController<ContentMapsView> {
        let provider = MapExternalData()
        let interactor = MapInteractor(provider: provider)
        let presenter = MapPresenter(radius: radius, interactor: interactor)
        let view = ContentMapsView(presenter: presenter)
        let contentView = UIHostingController(rootView: view)
        return contentView
    }
}
