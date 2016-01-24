import UIKit
import MapKit
import db
import CoreLocation
import iAd

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var bannerView: ADBannerView!
    @IBOutlet weak var mapView: MKMapView!
    
    var stores: [Store]?
    
    var annotations: [MKAnnotation]?
    
    var senderView: MKAnnotationView?
    var storeRadiusInMeters: Double = Double(NSUserDefaults().integerForKey("StoreRadius"))
    let locationManager = CLLocationManager()
    var currentLocation = CLLocation()
    var currCircle = MKCircle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        mapView.mapType = MKMapType.Hybrid
        
        let stores = DbController.sharedDBInstance.realm.objects(Store)
        self.stores = stores.reverse()
        
        //get users location
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        mapView.showsUserLocation = true
        currentLocation = CLLocation(latitude: 46.310409, longitude: 16.343013) //ZA PROBU
        centerMapOnLocation(currentLocation)
        generateAnnotations()
        
        bannerView.delegate = self
        bannerView.hidden = true
        
        addRadiusCircle(currentLocation)
        
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if control == view.rightCalloutAccessoryView{
            print(view.annotation!.title) // annotation's title
            print(view.annotation!.subtitle) // annotation's subttitle
            self.senderView = view
            
            performSegueWithIdentifier("onShowDiscountSegue", sender: nil)
        }
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let circle = MKCircleRenderer(overlay: overlay)
        circle.strokeColor = UIColor.blueColor()
        circle.fillColor = UIColor(red: 0, green: 255, blue: 0, alpha: 0.2)
        circle.lineWidth = 1
        return circle
    }
    
    func addRadiusCircle(location: CLLocation){
        let circle = MKCircle(centerCoordinate: location.coordinate, radius: Double(NSUserDefaults.standardUserDefaults().integerForKey("StoreRadius")) as CLLocationDistance)
        self.currCircle = circle
        self.mapView.addOverlay(circle)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "onShowDiscountSegue"
        {
            if let destination = segue.destinationViewController as? DiscountsViewController
            {
                
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
        print("current radius is:", storeRadiusInMeters)
        for store in stores! {
            
            let location = CLLocation(latitude: Double(store.latitude), longitude: Double(store.longitude))
            print("current distance for store is:",location.distanceFromLocation(currentLocation))
            if(location.distanceFromLocation(currentLocation)<storeRadiusInMeters){
                let artwork = Artwork(title: store.name,
                    locationName: store.desc,
                    storeId: String(store.remoteId),
                    discipline: "NaN",
                    coordinate: CLLocationCoordinate2D(latitude: Double(store.latitude),longitude: Double(store.longitude)))
                annArray.append(artwork)
            }
            
        }
        mapView.addAnnotations(annArray)
        
        
    }
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation.isKindOfClass(mapView.userLocation.classForCoder)
        {
            return nil
        }
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        if(pinView == nil)
        {
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

extension MapViewController: ADBannerViewDelegate
{
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        bannerView.hidden = false
    }
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        bannerView.hidden = true
    }
}

extension MapViewController: CLLocationManagerDelegate
{
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        self.locationManager.stopUpdatingLocation()
        
        let location = locations.last! as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        currentLocation = location
        self.mapView.removeOverlay(self.currCircle)
        addRadiusCircle(currentLocation)
        
        self.mapView.setRegion(region, animated: true)
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        
        self.locationManager.stopUpdatingLocation()
    }
}
