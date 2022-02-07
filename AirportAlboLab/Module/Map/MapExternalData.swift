//
//  MapExternalData.swift
//  AirportAlboLab
//
//  Created by Carlos Rodrigez on 06/02/2022.
//

import Foundation
import Combine


protocol MapExternalDataProtocol {
    var ouput : MapExternalDataProtocolOuput? {get set}
    
    func updateAirports(with location : LocationAndRadius)
}

protocol MapExternalDataProtocolOuput {
    func didLoadOirports( airports : Airports )
}

class MapExternalData : MapExternalDataProtocol  {
    
    var ouput : MapExternalDataProtocolOuput?
    
    
    func updateAirports(with location : LocationAndRadius) {
        let headers = [
            "x-rapidapi-host": "aerodatabox.p.rapidapi.com",
            "x-rapidapi-key": "2718de00b7msh74fc0baca265b66p19ae5ejsna17533ca673c"
        ]
        
        guard let url = getUrl(location) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            guard let dato = data,
                  error == nil,
                  let respuesta = response as? HTTPURLResponse
            else { return }
            
            if respuesta.statusCode == 200 {
                do{
                    if let datastr = String(data: data!, encoding: String.Encoding.utf8){
                        print("la respuesta en data es: \(datastr)")
                    }
                    let decoder = JSONDecoder()
                    let arrayAirpot = try decoder.decode(Airports.self, from: dato)
                    self.ouput?.didLoadOirports(airports: arrayAirpot)
                }catch let errorJson {
                    print("error json \(errorJson)")
                }
            }
        })

        dataTask.resume()
    }
    
    private func getUrl(_ location : LocationAndRadius) -> URL? {
        let strLat = String(location.location.lat)
        let strLon = String(location.location.lon)
        let strRadius = String(location.radius)
        let strUrl = "https://aerodatabox.p.rapidapi.com/airports/search/location/\(strLat)/\(strLon)/km/\(strRadius)/16?withFlightInfoOnly=false"
        return URL(string: strUrl)
    }
    
    
}


