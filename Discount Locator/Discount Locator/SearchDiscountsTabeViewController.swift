//
//  SearchDiscountsTabeViewController.swift
//  Discount Locator
//
//  Created by Faculty of Organisation and Informatics on 21/12/15.
//  Copyright © 2015 air. All rights reserved.
//

import UIKit
import db
import core
class SearchDiscountsTabeViewController: UITableViewController, UISearchResultsUpdating, UIGestureRecognizerDelegate{
    //implementiramo protokol UISearchResultsUpdating - jedina potrebna metoda je updateSearchResultsForSearchController te property koji uzimaUISearchController ()
    //protokol sluzi za implementaciju promjene stanja kad user upise nesto u search bar
    
    var discounts: [Discount] = []
    var searchDataLoader = SearchDataLoader()
    var resultSearchController = UISearchController ()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        searchDataLoader.onDataLoadedDelegate = self
               //custom backswipe pošto smo došli iz modalviewa na
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.addTarget(self, action: "handleGesture:")
        self.backSwipeCheck()
        
        self.resultSearchController = UISearchController(searchResultsController: nil) //novi searchbar
        self.resultSearchController.searchResultsUpdater=self
        self.resultSearchController.dimsBackgroundDuringPresentation = false //inače bi dimmao/disableo cijeli tableview dolje (zapravo cijeli viewcontroller) - nebi mogo kliknut na discount
        self.resultSearchController.searchBar.sizeToFit() //preko cijelog ekrana
        self.tableView.tableHeaderView = self.resultSearchController.searchBar //stavljamo searchbar u zaglavlje tableviewa
        self.resultSearchController.searchBar.placeholder="search discounts..."
        definesPresentationContext=true //ako odeš na neki drugi ViewController search bar nece ostati tu
        searchDataLoader.SearchData("")

    }
      
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func handleGesture(gestureRecognizer:UIGestureRecognizer){
        if(gestureRecognizer.state == .Ended) {
             performSegueWithIdentifier("searchToRevealSegue", sender: self)
        }
    }
        //helper funkcija kod filtriranja discountova
    func filterContentForSearchText(searchText: String, scope: String = "All") { //pretrazivanje po imenu discounta i po descriptionu
        //filter() takes a closure of type (discount: Discount) -> Bool. It then loops over all the elements of the array, and calls the closure, passing in the current element, for every one of the elements.
        
        //dodaj u filtar i description (posto u njemu moze pisati artikl ili nesto slicno)
        searchDataLoader.SearchData(searchText)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.discounts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("DiscountCell", forIndexPath: indexPath) as UITableViewCell
        let discount: Discount
        discount = discounts[indexPath.row]
        cell.textLabel!.text = discount.name
        cell.detailTextLabel!.text = discount.desc
        return cell
    }
    //kad god user doda/oduzima tekst iz search bara, UISearchController će obavijestiti SearchDiscountsTabeViewController klasu (odnosno klasu koja implementira gornji protokol) putem ove metode
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) { //metoda koja reagira na klik discounta (reda tabele)
        
        let title = "📈 " + discounts[indexPath.row].name + " : " + String(discounts[indexPath.row].discount) + "%"
        
        var message = discounts[indexPath.row].desc + "\n\n"
        message += "📅 " + discounts[indexPath.row].startDate + "\n"
        message +=  "📅 " + discounts[indexPath.row].endDate + "\n\n"
        message +=  "🏪 " + discounts[indexPath.row].store!.name + "\n"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Default, handler: nil))
        
        presentViewController(alert, animated: true, completion: nil)
        
        print(indexPath.row)
    }

}
extension SearchDiscountsTabeViewController: OnDataLoadedDelegate {
    func onDataLoaded(stores: [Store], discounts: [Discount]) {
        self.discounts=discounts
        tableView.reloadData() //pozivaju se 2 metode tableView
    }
}
