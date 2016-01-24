import UIKit
import db

class DiscountsViewController: UITableViewController {
    
    var discounts: [Discount]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return discounts!.count
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("DiscountCell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel!.text = self.discounts![indexPath.row].name
        cell.detailTextLabel!.text = self.discounts![indexPath.row].desc
        
        return cell
    }
    
}