import MapKit
import SwiftUI
import UIKit

/**
 Code taken from: https://github.com/apatronl/YouTube/blob/main/Directions/Directions/ContentView.swift
 annotations and overlays don't seem to be supported in SwiftUI yet.
 */

struct AnnotatableRouteMapView: UIViewRepresentable {
  typealias UIViewType = MKMapView

  @EnvironmentObject var widgetInfo: WidgetInfo
    
  @Binding var destinationLocation: CLLocationCoordinate2D?
  @Binding var region: MKCoordinateRegion

  func makeCoordinator() -> MapViewCoordinator {
    return MapViewCoordinator()
  }

  func makeUIView(context: Context) -> MKMapView {
    let mapView = MKMapView()
    mapView.delegate = context.coordinator
    mapView.userTrackingMode = .follow
    mapView.showsUserLocation = true
      
    return mapView
  }
    
  func updateUIView(_ uiView: MKMapView, context: Context) {
      let widgetUserLocation = MKCoordinateRegion(center: widgetInfo.widgetsUserLocation, span: LocationDefaults.span)
      
      let newRegion = widgetInfo.updateMap ? widgetUserLocation : region
      uiView.setRegion(newRegion, animated: true)
      
      guard let destinationLocation = destinationLocation else {
         return
      }

      let userLocationPlacemark = MKPlacemark(coordinate: newRegion.center)
      let destinationLocationPlacemark = MKPlacemark(coordinate: destinationLocation)
      let destinationPointAnnotation = MKPointAnnotation()
      destinationPointAnnotation.coordinate = destinationLocationPlacemark.coordinate
      destinationPointAnnotation.title = "bikeshare"

      let request = MKDirections.Request()
      request.source = MKMapItem(placemark: userLocationPlacemark)
      request.destination = MKMapItem(placemark: destinationLocationPlacemark)
      request.transportType = .walking

      let directions = MKDirections(request: request)
      directions.calculate { response, error in
        guard let route = response?.routes.first else { return }
      
          uiView.removeAnnotations(uiView.annotations)
          uiView.removeOverlays(uiView.overlays)
          uiView.addAnnotations([destinationPointAnnotation])
          uiView.addOverlay(route.polyline)
          uiView.setVisibleMapRect(
          route.polyline.boundingMapRect,
          edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
          animated: true)
      }
  }

  class MapViewCoordinator: NSObject, MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
      let renderer = MKPolylineRenderer(overlay: overlay)
      renderer.strokeColor = .blue
      renderer.lineWidth = 5
        
      return renderer
    }
  }
}
