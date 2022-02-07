//
//  AirportsListView.swift
//  AirportAlboLab
//
//  Created by Carlos Rodriguez on 05/02/2022.
//

import SwiftUI

struct AirportsListView: View {
    
    @ObservedObject var presenter : MapPresenter
    
    var body: some View {
        List(presenter.airportList){ airpot in
            Text(airpot.airport.name)
                .frame(width: 200)
                .multilineTextAlignment(.leading)

        }
    }
}


