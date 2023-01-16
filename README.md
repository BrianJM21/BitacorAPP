# BitacorAPP
## Academia iOS - Second Team Project (using MVVM design)

### Team members:
## Brian Jiménez Moedano - Poject Manager
## David Eduardo Batista Trujillo - Developer 1
## Alan Badillo Salas - Developer 2

## Entities

>BitacorAPP - Mantained by Alan Badillo Salas
```swift
class BitacoraEntity {

    let id: Int64
    let title: String
    let details: String
    let latitude: Decimal
    let longitude: Decimal
    let createAt: Date
    let updateAt: Date
}

class BitacoraStatusEntity {

    let label: String
    let status: String
    let created: Date
    
    Relationship with BitacoraEntity (No Inverse)
}
```

##  Model

>BitacoraModel - Mantained by Alan Salas Badillo

```swift
import Foundation
import CoreData
import Combine

class BitacoraModel {
    
// COREDATA CONTAINER
    
    /// Container of model (to store objects to `CoreData`)
    lazy var container: NSPersistentContainer
    
    
    
    
    // MODEL STATES
    
    /// List of *bitácoras*
    @Published var bitacoras: [BitacoraEntity] = []
    
    /// List of *status of bitácoras*
    @Published var bitacoraStatus: [BitacoraStatusEntity] = []
    
    /// Current selected *bitácora* if exists
    @Published var bitacoraSelected: BitacoraEntity?
    
    /// List of *status* of current selected *bitácora* when is selected
    @Published var statusOfBitacoraSelected: [BitacoraStatusEntity] = []
    
    
    
    
    // MODEL OPERATIONS
    
    /// Loads list of *bitácoras* from the *CoreData*
    func loadBitacoras() {
    
    /// Loads list of *status of bitácoras* from the *CoreData*
    func loadStatusOfBitacoras() 
    
    /// Finds the *bitácora* by *id*, filter their *status of this bitácora*
    /// and finally assing it to the current selected *bitácora* and the
    /// current *status of bitácora* list
    func selectBitacora(byId id: Int)
    
    /// Creates a new *bitácora*
    func addBitacora(latitude lat: Decimal, longitude lon: Decimal) {
        
    /// Some attributes are set by default
    /// *NOTE:* current *bitácoras* is filtered to get max id, if *bitacoras*
    /// is empty, then set a default *id* of: 1
        bitacoraToAdd.id = bitacoraWithMaxId.id + 1    
        bitacoraToAdd.title = "Untitled"
        bitacoraToAdd.details = "No details"
        bitacoraToAdd.created = Date.now
        bitacoraToAdd.latitude = NSDecimalNumber(decimal: lat)
        bitacoraToAdd.longitude = NSDecimalNumber(decimal: lon)
        bitacoraToAdd.updated = nil
        
    }
    
    /// Updates the current selected *bitácora* either if title or details
    /// is filled
    func updateSelectedBitacora(title: String?, details: String?) 
    
    /// Creates a new *status* for the current *selected bitácora*
    func addStatusInSelectedBitacora(label: String, status: String)

```

##  Views

>BitacoraHomeView - Mantained by David Eduardo Batista Trujillo

```swift

import Foundation

/// Protocol needed by view-controllers with data notifiers from view-model
protocol BitacoraHomeView: NSObject {
    
    /// Removes the current *Bitacoras Annotations* from the `homeMapView`, then recives the latest *Bitacoras*
    ///from the model and assign it back to the `homeMapView`.
    func bitacora(bitacoras: [BitacoraEntity])
    
    /// Updates the floating `bitacoraView` with the current *selectedBitacora*, also animates the `bitacoraView`
    /// to apper at the bottom of the screen.
    func bitacora(bitacoraSelected: BitacoraEntity)
}

```

>BitacoraDetailsView - Mantained by Alan Badillo Salas

```swift

import Foundation

/// Protocol needed by view-controllers with data notifiers from view-model
protocol BitacoraDetailsView: NSObject {
    
    // FUNCTIONS WITH DATA NOTIFIERS FROM VIEW-MODEL
    
    /// Receive the current *selected bitácora* when it changes or made request
    func bitacora(bitacoraSelected bitacora: BitacoraEntity)
    
    /// Receive the list of *status* for the current *selected bitácora* when it changes or made request
    func bitacora(statusOfBitacoraSelected status: [BitacoraStatusEntity])
    
    /// Receive the current *selected bitácora* when it successfully updates
    func bitacora(bitacoraUpdated bitacora: BitacoraEntity)
    
}

```

## View-Models

>BitacoraHomeViewModel - Mantained by David Eduardo Batista Trujillo

```swift

import Foundation
import Combine

class BitacoraHomeViewModel {
   
    // MODEL AND VIEW BINDING
    
    weak var model: BitacoraModel?
    weak var view: BitacoraHomeView?

    // SUBSCRIBERS OF MODEL (WATCHERS/OBSERVABLES)
    
    var bitacorasSubscriber: AnyCancellable?
    var bitacoraSelectedSubscriber: AnyCancellable?
    
    // INITIALIZER
    
    /// Initialize new *View-Model* with the attached *model* to self and start
    /// listening to changes from the *model* with a subscriber sink method
    init(model: BitacoraModel)
        
    /// Updates the *model* with a newly created *Bitacora*
    func addBitacora(latitude lat: Decimal, longitude lon: Decimal)
    
    /// Updates the *model* with the current selected *Bitacora*
    func selectBitacora(byId id: Int)
    
    /// Updates the *Bitacoras Annotations* with the lates *Bitacoras* held by the *model*
    func refreshBitacoras()
}

```

>BitacoraDetailsViewModel - Mantained by Alan Badillo Salas

```swift

import Foundation
import Combine

class BitacoraDetailsViewModel {
    
    // MODEL AND VIEW BINDING
    
    /// *Model* attached
    weak var model: BitacoraModel?
    
    /// *View* attached (associated view)
    weak var view: BitacoraDetailsView?
    
    // SUBSCRIBERS OF MODEL (WATCHERS/OBSERVABLES)
    
    /// Subscribe to the *model* `$bitacoraSelected` publisher
    var bitacoraSelectedSubscriber: AnyCancellable?
    
    /// Subscribe to the *model* `$statusOfBitacoraSelected` publisher
    var statusOfBitacoraSelectedSubscriber: AnyCancellable?
    
    /// Subscribe to the *model* `$bitacoras` publisher
    ///
    /// When we update the current *selected bitácora*
    /// all the *bitácoras* will be updated; themn,
    /// when we receive the *bitácoras* change notification
    /// we need to notify the view that the current *selected bitácora* was updated
    var bitacorasSubscriber: AnyCancellable?
    
    // INITIALIZER
    
    /// Initialize new *View-Model* with the attached *model* to *self*
    init(model: BitacoraModel)
    
    /// Listen changes from the *model* with a subscriber sink method
    func subscribeToModel() 
    
    /// Unsubscribe *model* with a subsciber cancel method and a nil reference
    func unsubscribeToModel() 
    
    /// Release the *model* and *view* if necessary with a nil reference
    func dispose()
    
    // OPERATIONS (FROM VIEW TO MODEL)
    
    /// Send the current *selected bitácora* to the *view*
    func refreshBitacoraSelected()
    
    /// Notify the current *selected Bitacora* was updated to the *view*
    func notifyBitacoraUpdated() {
    
    /// Send the list of *status* of the current *selected bitácora* to the *view*
    func refreshStatusOfBitacoraSelected()
    
    /// Adds a new *status* to the current *selected Bitacora*
    func addStatusInSelectedBitacora(label: String, status: String)
    
    /// Updates the current *selected Bitacora*
    func updateBitacora(title: String?, details: String?)
    
}

```

## ViewControllers

>BitacoraHomeViewController - Mantained by David Eduardo Batista Trujillo

```swift

import UIKit
import MapKit

class BitacoraHomeViewController: UIViewController {
    
    // *ViewModel* binding
    weak var viewModel: BitacoraHomeViewModel?
    
    // "Floating" subview with the *Bitacora Annotations* details
    @IBOutlet weak var bitacoraView: UIView!
    
    // LabelViews for the *title*, *id* and *coordinates* of the *Bitacora Annotations*
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var latlonLabel: UILabel!
    
    // Map View
    @IBOutlet weak var homeMapView: MKMapView!
    
    // Auxiliary logic flags for initializing the *Bitacora Anotations* in the map,
    // and the floating subview animation
    var autoloadBitacoras: Bool = true
    var isHidden: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Default User Location
        let initialLocation = CLLocation(latitude: 19.397956, longitude: -99.17199)
        homeMapView.centerToLocation(initialLocation)
        
        // Default View Pop
        setupView()
        
        // The ViewController is the Map Delegate
        self.homeMapView.delegate = self
        
        // Set up the Long Press Gesture to the map
        self.setupGestureLongPressToMap()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // Load *Bitacoras* at the start of the APP and hides the "floating" subview
        if autoloadBitacotas {
            self.viewModel?.refreshBitacoras()
            self.autoloadBitacotas = false
            
            self.isHidden = true
            UIView.animate(withDuration: 0.8, delay: 0) {
                self.bitacotaView.transform = self.bitacotaView.transform.translatedBy(x: 0, y: 300)
            }
        }
    }
    
    // Navigates from HomeView to DetailsView
    @IBAction func goDetailsAction(_ sender: Any?)
    
    // Setup the LongPress gesture and incorporates it to the Map View
    func setupGestureLongPressToMap() 
    
    // Sets up the LongPress gesture handler to recognize only the began State
    // and associate it with the *addBitacora* functionality
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) 

    // Smooth the "floating" subview corners
    func setupView()
    
}

// Set up the gesture recognizer delegate
extension BitacoraHomeViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive press: UIPress) -> Bool {
        return false
    }
    
}

// Bitacora Annotation inherits from the MKPointAnnotation adding a Bitacora property
class BitacoraAnnotation: MKPointAnnotation {
    
    var bitacora: BitacoraEntity?
    
}

// HomeView protocol implementation
extension BitacoraHomeViewController: BitacoraHomeView {
    
    // Map view clears the current *Bitacoras Annotations*, loads the most recent *Bitacoras* from the *model*
    // as a new array of *Bitacoras Annotations*, and refresh the Map Annotations.
    func bitacora(bitacoras: [BitacoraEntity]) 
    
    // "Floating" subview is animated to appear, labels within the subview are updated with the *selected Bitacora*
    // information
    func bitacora(bitacoraSelected: BitacoraEntity) 
}


// MARK: extension MkMapViewDelegate
extension BitacoraHomeViewController: MKMapViewDelegate {
    
    // Notify the *viewmodel* to update the *selected Bitacora*
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) 
    
    // Hides the "floating" subview at deselect annotation
    func mapView(_ mapView: MKMapView, didDeselect annotation: MKAnnotation) 

// MARK: extension MKmapView
private extension MKMapView {

  // Sets up the zoom ath the user current location
  func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 500) 
}

```

>BitacoraDetailsViewController - Mantained by Alan Badillo Salas

```swift



```

## SceneDelegate

>SceneDelegate - Mantained by David Eduardo Batista Trujillo

```swift



```
