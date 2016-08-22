//
//  ViewController.swift
//  SideViewPractice
//
//  Created by Hana  Demas on 20/08/16.
//  Copyright © 2016 ___HANADEMAS___. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SideBarDelegate ,UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate {
    
    // MARK: Properties
    var searchItemsArray = [SearchItem]()
    var filteredSearchItems = [SearchItem]()
    var sideBar:SideBar = SideBar()
    @IBOutlet var tableView: UITableView!
    
    
    // MARK: ViewController Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideBar = SideBar(sourceView: self.view, menuItems: ["First Item", "Second Item", "Third Item"])
        sideBar.delegate = self
        
        // add items to the array
        searchItemsArray.append(SearchItem(name:"Apple"))
        searchItemsArray.append(SearchItem(name:"Microsoft"))
        searchItemsArray.append(SearchItem(name:"Samsung"))
        searchItemsArray.append(SearchItem(name:"Facebook"))
        searchItemsArray.append(SearchItem(name:"itune"))
        searchItemsArray.append(SearchItem(name:"ipad"))
        searchItemsArray.append(SearchItem(name:"iphone"))
        searchItemsArray.append(SearchItem(name:"icar"))
        searchItemsArray.append(SearchItem(name:"Ebay"))
        searchItemsArray.append(SearchItem(name:"Vea Software"))
        searchItemsArray.append(SearchItem(name:"Intel"))
        searchItemsArray.append(SearchItem(name:"IBM"))
        
        self.tableView.reloadData()
    }
    
    // MARK : Custom methods
    func sideBarDidSelectRowCellAtIndex(index:Int) {
        if(index == 0) {
            print("Hello")
        }
    }
    
    func filterContentForSearchRessult(searchResult:String, scope:String = "Title") {
        self.filteredSearchItems = self.searchItemsArray.filter({(item:SearchItem) ->Bool in
            let catagoryMatch = (scope == "Title")
            let stringMatch = item.name.rangeOfString(searchResult)
            
            return catagoryMatch && (stringMatch != nil)})
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == self.searchDisplayController?.searchResultsTableView) {
            return filteredSearchItems.count
            
        } else {
            return searchItemsArray.count
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        var item:SearchItem
        
        if(tableView == self.searchDisplayController?.searchResultsTableView) {
            item = self.filteredSearchItems[indexPath.row]
            
        } else {
            item = self.searchItemsArray[indexPath.row]
            
        }
        cell.textLabel?.text = item.name
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        var item:SearchItem
        
        if(tableView == self.searchDisplayController?.searchResultsTableView) {
            item = self.filteredSearchItems[indexPath.row]
        } else {
            item = self.searchItemsArray[indexPath.row]
            
        }
        print(item.name)
    }
    
    
    //MARK : Searchbar datasource and delegate methods
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String?) -> Bool {
        self.filterContentForSearchRessult(searchString!, scope: "Title")
        return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        self.filterContentForSearchRessult((self.searchDisplayController?.searchBar.text)!, scope: "Title")
        return true
    }
}

