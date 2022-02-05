//
//  MapsView.swift
//  AirportAlboLab
//
//  Created by Carlos Rodriguez on 05/02/2022.
//

import SwiftUI
import MapKit

struct MapsView: View {
    
    @ObservedObject var presenter = MapPresenter()
    
    @State private var manager = CLLocationManager()
    @State private var alert = false
    
    
       
       var body: some View {
           Maps(manager: self.$manager, alerta: self.$alert)
               .alert(isPresented: self.$alert) {
                   Alert(title: Text("Necesitamos la localización para continuar..."))
           }
       }
}

//struct MapsView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapsView()
//    }
//}

struct Maps : UIViewRepresentable {
    
    @Binding var manager : CLLocationManager
       @Binding var alerta : Bool
       let map = MKMapView()
       func makeCoordinator() -> Maps.Coordinator {
           return Coordinator(conexion: self)
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
           
           init(conexion : Maps){
               self.conexion = conexion
           }
           
           func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
               if status == .denied {
                   self.conexion.alerta.toggle()
               }
           }
           
           func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
               
               let location = locations.last
               let annotation = MKPointAnnotation()
               let ezeiz = MKPointAnnotation()
               let coordinateEz = CLLocationCoordinate2D(latitude: -34.849758, longitude: -58.516460)
               ezeiz.coordinate = coordinateEz
               ezeiz.title = "Ezeiza"
               
               let geocoder = CLGeocoder()
               geocoder.reverseGeocodeLocation(location!) { (place, error) in
                   
                   if error != nil {
                       print((error?.localizedDescription)!)
                       return
                   }
                   
                   let place = place?.first?.locality
                   annotation.title = place
                   annotation.coordinate = location!.coordinate
                   self.conexion.map.removeAnnotations(self.conexion.map.annotations)
//                   self.conexion.map.addAnnotation(annotation)
                   self.conexion.map.addAnnotations([annotation,ezeiz])
                   let span = MKCoordinateSpan(latitudeDelta: 5.0, longitudeDelta: 5.0)
                   let region = MKCoordinateRegion(center: location!.coordinate, span: span)
                   self.conexion.map.region = region
                   
               }
               
           }
           
       }
    
}
