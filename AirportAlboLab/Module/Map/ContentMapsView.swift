//
//  ContentMapsView.swift
//  AirportAlboLab
//
//  Created by Carlos Rodriguez on 05/02/2022.
//

import SwiftUI

struct ContentMapsView: View {
    
    @ObservedObject var presenter : MapPresenter
    
    var body: some View {
        TabView{
            MapView(presenter: self.presenter)
                .tabItem {
                Image(systemName: "map.fill")
            }
            AirportsListView(presenter: self.presenter).tabItem{
                Image(systemName: "mappin.circle.fill")
            }
        }
    }
}


