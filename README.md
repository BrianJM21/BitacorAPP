### BitacorAPP
# Academia iOS Segundo Proyecto en Equipo (MVVM)
## Proyecto realizado por:

# Brian Jiménez Moedano
# David Eduardo Batista
# Alan

## Model

>BitacoraModel
```swift
struct BitacoraEntity {
// El id es el identificador del incidente en la Bitacora
    let id: Int
//El title será el nombre del incidente, el cual se desplegara en la anotacion del mapa concatenado al id
    let title: String/Int
//El subtitle será la descripción del incidente
    let subtitle: String

    let coordinate: ()
}
```