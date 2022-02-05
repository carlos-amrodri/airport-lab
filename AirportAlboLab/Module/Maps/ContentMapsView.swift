//
//  ContentMapsView.swift
//  AirportAlboLab
//
//  Created by Carlos Rodriguez on 05/02/2022.
//

import SwiftUI

struct ContentMapsView: View {
    var body: some View {
        TabView{
            MapsView().tabItem {
                Image(systemName: "map.fill")
            }
            AirportsListView().tabItem{
                Image(systemName: "mappin.circle.fill")
            }
        }
    }
}

struct ContentMapsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentMapsView()
    }
}
