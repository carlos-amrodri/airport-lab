//
//  MapPresenter.swift
//  AirportAlboLab
//
//  Created by Carlos Rodrigez on 05/02/2022.
//

import Foundation
import Combine


class MapPresenter : ObservableObject {
    
    init(){
        print("soy el presenter map")
        getAirports()
    }
    
    private func getAirports(){
        let headers = [
            "x-rapidapi-host": "aerodatabox.p.rapidapi.com",
            "x-rapidapi-key": "2718de00b7msh74fc0baca265b66p19ae5ejsna17533ca673c"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://aerodatabox.p.rapidapi.com/airports/search/location/51.511142/-0.103869/km/100/16?withFlightInfoOnly=true")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                
                
                if let resp = response as? HTTPURLResponse {
                    print("status :\(resp.statusCode)")
                }
                if let datastr = String(data: data!, encoding: String.Encoding.utf8){
                    print("la respuesta en data es: \(datastr)")
                }
                
                do{
                    let decoder = JSONDecoder()
                    let airport = try decoder.decode(Airports.self, from: data!)
                    print("exito! \(airport)")
                }catch let errorJson {
                    print("error json \(errorJson)")
                }
                
            }
        })

        dataTask.resume()
    }
    
}
