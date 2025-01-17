//
//  MapView.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 09/01/25.
//

import SwiftUI
import MapKit


struct MapView: View {
    let latitude: Double
    let longitude: Double
    let restoName: String
    
    @State private var cameraPosition: MapCameraPosition
    
    init(latitude: Double, longitude: Double, restoName: String) {
        self.latitude = latitude
        self.longitude = longitude
        self.restoName = restoName
        _cameraPosition = State(initialValue: .region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            )
        ))
    }
    
    var body: some View {
        Map(position: $cameraPosition) {
            Annotation(restoName, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude)) {
                VStack(spacing: 0) {
                    ZStack {
                        Circle()
                            .fill(.white)
                            .frame(width: 44, height: 44)
                            .shadow(radius: 3)
                        
                        Image(systemName: "fork.knife")
                            .font(.system(size: 24))
                            .foregroundColor(.orange)
                    }
                    
                    Image(systemName: "arrowtriangle.down.fill")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .offset(y: -3)
                }
            }
        }
        .mapControls {
            MapUserLocationButton()
            MapCompass()
        }
        .ignoresSafeArea()
    }
}


#Preview {
    MapView(latitude: -6.995573952315142, longitude: 110.43253134165279, restoName: "Addien")
}
