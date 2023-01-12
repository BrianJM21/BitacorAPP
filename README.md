# BitacorAPP
## Academia iOS - Segundo Proyecto en Equipo (MVVM)
### Proyecto realizado por:

## Brian Jiménez Moedano - Líder de Proyecto
## David Eduardo Batista Trujillo - Desarrollador 1
## Alan Badillo Salas - Desarrollador 2

## Entidades

>BitacorAPP
```swift
class BitacoraEntity {

    let id: Int32
    let title: String
    let details: String
    let latitude: Decimal
    let longitud: Decimal
    let created: Date
    let updated: Date
}

class BitacoraStatusEntity {

    let label: String
    let status: String
    let created: Date
    
    Relationship with BitacoraEntity (No Inverse)
}
```

##  Modelo

>BitacoraModel

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
