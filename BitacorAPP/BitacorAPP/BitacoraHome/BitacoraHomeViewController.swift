//
//  BitacoraHomeViewController.swift
//  BitacorAPP
//
//  Created by MacBook Pro on 12/01/23.
//

import UIKit
import MapKit

class BitacoraHomeViewController: UIViewController {
    
    
    weak var viewModel: BitacoraHomeViewModel?
    
    // Bitacora Outlet para animación
    @IBOutlet weak var bitacotaView: UIView!
    
    // TODO: Documentación de Outels de la Bitacora
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var latlonLabel: UILabel!
    
    // TODO: Documentanción definicion IBOULETS MAP
    @IBOutlet weak var homeMapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Default Location
        let initialLocation = CLLocation(latitude: 19.397956, longitude: -99.17199)
        homeMapView.centerToLocation(initialLocation)
        
        // Default View Pop
        setupView()
        
        self.homeMapView.delegate = self
        
        self.setupGestureLongPressToMap()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        // TODO: Refresh bitácoras
        self.viewModel?.refreshBitacoras()
    }
    
    
    @IBAction func goDetailsAction(_ sender: Any?) {
        
        self.navigationController?.pushViewController(BitacoraDetailsViewController(), animated: true)
    }
    
    func setupGestureLongPressToMap() {
        let gestureLongPress = UILongPressGestureRecognizer(target: self, action:#selector(self.handleLongPress))
        gestureLongPress.minimumPressDuration = 1
        gestureLongPress.delaysTouchesBegan = true
        gestureLongPress.delegate = self
        self.homeMapView.addGestureRecognizer(gestureLongPress)
    }
    
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        
        if gestureRecognizer.state == UIGestureRecognizer.State.ended {
                    return
        }
        
        else if gestureRecognizer.state == UIGestureRecognizer.State.began {
            
            let touchPoint = gestureRecognizer.location(in: self.homeMapView)
            
            let touchMapCoordinate =  self.homeMapView.convert(touchPoint, toCoordinateFrom: self.homeMapView)
            
            print(touchMapCoordinate)
            
            self.viewModel?.addBitacora(latitude: Decimal(touchMapCoordinate.latitude), longitude: Decimal(touchMapCoordinate.longitude))
            
        }
    }

    func setupView() {
        self.bitacotaView.layer.cornerRadius = bitacotaView.bounds.size.width / 30
    }
    
}

extension BitacoraHomeViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive press: UIPress) -> Bool {
        return false
    }
    
}

// TODO: Documentacion Extension de la Bitacora

class BitacoraAnnotation: MKPointAnnotation {
    
    var bitacora: BitacoraEntity?
    
}

extension BitacoraHomeViewController: BitacoraHomeView {
    
    func bitacora(bitacoras: [BitacoraEntity]) {
        // TODO: Implementación en el mapa con las bitacoras
        
        bitacoras.forEach { [weak self] bitacora in
            let mark = BitacoraAnnotation()
            
            mark.title = bitacora.title
            mark.bitacora = bitacora
            
            guard let latitud = bitacora.latitude else { return }
            guard let longitud = bitacora.longitude else { return }
            
            print("BITACORA: (\(latitud.doubleValue), \(longitud.doubleValue))")
            
            mark.coordinate = CLLocationCoordinate2D(latitude: latitud.doubleValue, longitude: longitud.doubleValue)
 
            self?.homeMapView.addAnnotation(mark)
        }
        
        homeMapView.reloadInputViews()
        
    }
    
    func bitacora(bitacoraSelected: BitacoraEntity) {
        
        // TODO: Implementación en el mapa cuando la bitacora sea seleccionada
        self.titleLabel.text = bitacoraSelected.title
        self.latlonLabel.text = "#\(bitacoraSelected.id) \(bitacoraSelected.latitude ?? 0.0) \(bitacoraSelected.longitude ?? 0.0)"
        
        guard let _ = bitacoraSelected.updateAt else {
            // La bitácora es nueva
            self.goDetailsAction(nil)
            return
        }
    
    }
}


// MARK: extension MkMapViewDelegate

extension BitacoraHomeViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        // Si la anotación seleccionada 
        if let bitacoraAnnotation = annotation as? BitacoraAnnotation {
            
            if let bitacora = bitacoraAnnotation.bitacora {
                self.viewModel?.selectBitacora(byId: Int(bitacora.id))
            }
            
        }
    }
    
}

// MARK: extension MKmapView
// center location
private extension MKMapView {
  func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 500) {
    let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}

