import UIKit
import db
import core
import ws
import Kingfisher
import RealmSwift

public class ViewController: UITableViewController {
    
    @IBOutlet weak var storesTableView: UITableView!
    var stores = [Store] ()
    var discounts = [Discount] ()
    
    var webServiceDataLoader = WebServiceDataLoader()
    var dbDataLoader = DBDataLoader()
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        //set User Defaults
        UserDefaults.checkIfUserDefaultsAreSet()
        
        //set default Realm DB configuration
        Realm.Configuration.defaultConfiguration = Realm.Configuration(
            schemaVersion: 4,
            migrationBlock: { migration, oldSchemaVersion in })
        
        if(NetConnection.Connection.isConnectedToNetwork() && NSUserDefaults.standardUserDefaults().boolForKey("EnableWebService")){
            webServiceDataLoader.onDataLoadedDelegate = self
            webServiceDataLoader.LoadData()
        }else{
            
            dbDataLoader.onDataLoadedDelegate = self
            dbDataLoader.LoadData()
        }

        
        //turn off animation because it's initial view controller
        self.animationCheck()
        
    }
    
    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    public override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stores.count
    }
    
    public override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! StoreTableViewCell
        var store: Store
        store = self.stores[indexPath.row]
        cell.storeTitle.text = store.name
        cell.storeDescription.text = store.desc
        cell.storeImageView.kf_setImageWithURL(NSURL(string:store.imgUrl)!)
        
        return cell
    }
    
    public override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDiscountsSegue" {
            if let destination = segue.destinationViewController as? DiscountsViewController {
                if let storeIndex = tableView.indexPathForSelectedRow {
                    destination.discounts = self.stores[storeIndex.row].discounts
                }
            }
        }
    }

}
extension ViewController:OnDataLoadedDelegate {
    public func onDataLoaded(stores: [Store], discounts: [Discount]) {
        self.stores=stores
        self.discounts=discounts
        tableView.reloadData()
    }
}
