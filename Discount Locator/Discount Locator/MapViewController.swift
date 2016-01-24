import UIKit
import MapKit
import db

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var stores: [Store]?
    
    var annotations: [MKAnnotation]?
    
    var senderView: MKAnnotationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        mapView.mapType = MKMapType.Hybrid
        
        let stores = DbController.sharedDBInstance.realm.objects(Store)
        self.stores = stores.reverse()
        
        centerMapOnLocation(CLLocation(latitude: 46.310409, longitude: 16.343013))
        
        generateAnnotations()
    }
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView{
            print(view.annotation!.title) // annotation's title
            print(view.annotation!.subtitle) // annotation's subttitle
            self.senderView = view
            
            performSegueWithIdentifier("onBasharSegue", sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "onBasharSegue"
        {
            if let destination = segue.destinationViewController as? DiscountsViewController
            {
                
                /*
                * Tako mi ALLAHA ovo moze drukcije!! ovo nije pravi put
                */
                var clickedStore: Store?
                for store in stores!
                {
                    if(store.name == (senderView?.annotation!.title)!)
                    {
                        clickedStore = store
                    }
                }
                destination.discounts = clickedStore!.discounts
            }
        }
    }
    
    
    func generateAnnotations(){
      
        var annArray: [MKAnnotation] = []
        
        for store in stores! {
            
            let artwork = Artwork(title: store.name,
                locationName: store.desc,
                storeId: String(store.remoteId),
                discipline: "NaN",
                coordinate: CLLocationCoordinate2D(latitude: Double(store.latitude),longitude: Double(store.longitude) ))
            annArray.append(artwork)
            
        }
        
        mapView.addAnnotations(annArray)
        
    
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        if(pinView == nil)
        {
            print("prntview je nil")
            
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true
            
        }
        
        let button = UIButton(type: UIButtonType.DetailDisclosure)
        pinView?.rightCalloutAccessoryView = button
        return pinView
    }
    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 20000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
