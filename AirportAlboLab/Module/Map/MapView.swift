//
//  MapView.swift
//  AirportAlboLab
//
//  Created by Carlos Rodrigez on 05/02/2022.
//

import SwiftUI
import MapKit



struct MapView: View {
    
    @State private var manager = CLLocationManager()
    @State private var alert = false
    
    @ObservedObject var presenter : MapPresenter
    
       
      var body: some View {
          Maps(manager: self.$manager, alerta: self.$alert, presenter: self.presenter)
              .alert(isPresented: self.$alert) {
                  Alert(title: Text("Necesitamos la localización para continuar..."))
          }
      }
}


struct Maps : UIViewRepresentable {
    
    @Binding var manager : CLLocationManager
    @Binding var alerta : Bool
    @ObservedObject var presenter : MapPresenter
    
    let map = MKMapView()
    
    
    

   func makeCoordinator() -> Maps.Coordinator {
       return Coordinator(conexion: self, presenter: presenter )
   }
   
   func makeUIView(context: UIViewRepresentableContext<Maps>) -> MKMapView {
       let coordinate = CLLocationCoordinate2D(latitude: 13.086, longitude: 80.2707)
       let span = MKCoordinateSpan(latitudeDelta: 5.0, longitudeDelta: 5.0)
       let region = MKCoordinateRegion(center: coordinate, span: span)
       map.region = region
       manager.requestWhenInUseAuthorization()
       manager.delegate = context.coordinator
       manager.startUpdatingLocation()
       return map
   }
   
   func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<Maps>) {
       
   }
       
       class Coordinator: NSObject, CLLocationManagerDelegate {
           
           var conexion : Maps
           @ObservedObject var presenter : MapPresenter
                      
           init(conexion : Maps, presenter : MapPresenter){
               self.conexion = conexion
               self.presenter = presenter
           }
           
           func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
               if status == .denied {
                   self.conexion.alerta.toggle()
               }
           }
           
           func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
               
               

               guard let current = manager.location?.coordinate,
                     let location = locations.last else{
                   return
               }
               
               presenter.getAirports(current.longitude, lon: current.longitude)
               
               let geocoder = CLGeocoder()
               geocoder.reverseGeocodeLocation(location) { (place, error) in
                   if error != nil {
                       print((error?.localizedDescription)!)
                       return
                   }
                   self.conexion.map.removeAnnotations(self.conexion.map.annotations)
                   self.conexion.map.addAnnotations((self.presenter.airportList))
                   let span = MKCoordinateSpan(latitudeDelta: 8.0, longitudeDelta: 8.0)
                   let region = MKCoordinateRegion(center: location.coordinate, span: span)
                   self.conexion.map.region = region
                   
               }
               
           }
           
       }
    
}
