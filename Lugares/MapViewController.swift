//
//  MapViewController.swift
//  Lugares
//
//  Created by Jose Martin Salcedo Lazaro on 11/3/17.
//  Copyright © 2017 Jose Martin Salcedo Lazaro. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController {
  
  var place: Place!
  @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
      
//      decirle a la vista que gobierno al delegado
      self.mapView.delegate = self
      
//      para mostrar el trafico en el mapa
      self.mapView.showsTraffic = true
      
//      sirve para mostrar el zoom en el mapa
      self.mapView.showsScale = true
      
//      mostrar la brujula
      self.mapView.showsCompass = true
      
      let geoCoder = CLGeocoder()
//      confifura el geocoder
      geoCoder.geocodeAddressString(place.location) { (placemakers, error) in
        if error == nil{
//          procesar los lugares
          for data in placemakers!{
            let anotattion = MKPointAnnotation()
            anotattion.title = self.place.name
            anotattion.subtitle = self.place.type
            anotattion.coordinate = (data.location?.coordinate)!
            
            
            self.mapView.showAnnotations([anotattion], animated: true)
            
          }
        }else{
          print("se presento un error \(error?.localizedDescription)")
        }
      }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MapViewController: MKMapViewDelegate{

  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    
    let indetifier = "myPin"
    
    if annotation.isKind(of: MKUserLocation.self){
      return nil
    }
    
    var anotattionView: MKPinAnnotationView? = self.mapView.dequeueReusableAnnotationView(withIdentifier: indetifier) as? MKPinAnnotationView
    
    if anotattionView == nil {
      anotattionView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: indetifier)
      anotattionView?.canShowCallout = true
    }
    
    let imageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 52.0, height: 52.0))
    imageView.image = self.place.image
    
    anotattionView?.leftCalloutAccessoryView = imageView
    anotattionView?.pinTintColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
    
    return anotattionView
  }
}
