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
import 
import Combine

class BitacoraModel {

    var bitacoras: [BitacoraEntity] = []
    
    var bitacoraStatus: [BitacoraStatusEntity] = []
    
    var bitacoraSelected: BitacoraEntity?
    
    var 
}
```
