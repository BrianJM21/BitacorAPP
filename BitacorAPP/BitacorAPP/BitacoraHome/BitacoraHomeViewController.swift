//
//  BitacoraHomeViewController.swift
//  BitacorAPP
//
//  Created by MacBook Pro on 12/01/23.
//

import UIKit
import MapKit

class BitacoraHomeViewController: UIViewController {
    // TODO: Documentanción definicion IBOULETS
    
    
    weak var viewModel: BitacoraHomeViewModel?
    // TODO: Documentación de Outles de la View Emergente
    
    
    @IBOutlet weak var bitacotaView: UIView!
    
    
    
    
    @IBOutlet weak var homeMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()

    }

    @IBAction func goDetailsAction(_ sender: Any) {
        
        self.navigationController?.pushViewController(BitacoraDetailsViewController(), animated: true)
    }
    
    
    func setupView() {
        self.bitacotaView.layer.cornerRadius = bitacotaView.bounds.size.width / 30
    }
    
}

extension BitacoraHomeViewController: BitacoraHomeView {
    
    func bitacora(bitacoras: [BitacoraEntity]) {
        // TODO: Implementación en el mapa con las bitacoras
    }
    
    func bitacora(bitacoraSelected: BitacoraEntity) {
        // TODO: Implementación en el mapa cuando la bitacora sea seleccionada
    }
    
    
}
