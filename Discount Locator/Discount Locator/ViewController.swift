import UIKit
import db
import Kingfisher
import RealmSwift

class ViewController: UITableViewController {
    
    @IBOutlet weak var storesTableView: UITableView!
    
    var webServiceDataLoader = WebServiceDataLoader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        Realm.Configuration.defaultConfiguration = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
        })
        
        webServiceDataLoader.storesTableView = self.storesTableView
        webServiceDataLoader.LoadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return webServiceDataLoader.stores.count
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! StoreTableViewCell
        
        var store: Store
        store = webServiceDataLoader.stores[indexPath.row]
        
        cell.storeTitle.text = store.name
        cell.storeDescription.text = store.desc
        cell.storeImageView.kf_setImageWithURL(NSURL(string:store.imgUrl)!)
        
        return cell
    }
    
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDiscountsSegue" {
            if let destination = segue.destinationViewController as? DiscountsViewController {
                if let storeIndex = tableView.indexPathForSelectedRow {
 
                    destination.discounts = webServiceDataLoader.stores[storeIndex.row].discounts
                    
                }
                
            }
        }
    }

}

