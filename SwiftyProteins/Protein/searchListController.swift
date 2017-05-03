//
//  searchListController.swift
//  Protein
//
//  Created by Jean-philippe LABRO on 10/25/16.
//  Copyright © 2016 Stefan-ciprian CIRCIU. All rights reserved.
//

import UIKit
import SceneKit

class searchListController:UITableViewController {
    
    @IBOutlet var ligandTableView: UITableView!
    let mainSB = UIStoryboard(name: "Main", bundle: nil)
    var allLigands:[ligand] = []
    var filteredLigands = [ligand]()
    var filter:Int = 0
    let searchController = UISearchController(searchResultsController: nil)
    var countFailDownloaded:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        
        // Setup the Search Bar
        tableView.tableHeaderView = searchController.searchBar

        ligandTableView.dataSource = self
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableViewAutomaticDimension
        ligandTableView.delegate = self
        ligandTableView.dataSource = self
        
        if (self.countFailDownloaded > 0){
            self.failDownloadedAlert()
        }
    }
    
    func failDownloadedAlert() {
        let count:Int = 1243 - self.countFailDownloaded
        let passwordAlert = UIAlertController(title: "Attention!", message: "\(count) sur 1243 ligands ont été téléchargé.", preferredStyle: UIAlertControllerStyle.alert)
        passwordAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
        }))
        present(passwordAlert, animated: true, completion: nil)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (filter == 0){
            return allLigands.count
        }
        else{
            return filteredLigands.count
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "ligandCell") as! ligandClass
        if (filter == 0){
            cell.ligands = self.allLigands[indexPath.row]
        }
        else{
            cell.ligands = self.filteredLigands[indexPath.row]
        }
        return cell;
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let GC = segue.destination as? GameViewController{
            if let cell = sender as? ligandClass{
                GC.lig = cell.ligands
            }
        }
    }
    func filterContentForSearchText(_ searchText: String, scope: String) {
        filteredLigands = allLigands.filter({( ligand : ligand) -> Bool in
            return ligand.id!.lowercased().contains(searchText.lowercased())
        })
        if (searchText == ""){
            filter = 0;
        }
        else{
            filter = 1
        }
        tableView.reloadData()
        print(searchText.lowercased())
    }
}

extension NSString {
    func condenseWhitespace() -> NSArray {
        var splitComponents = self.components(separatedBy: CharacterSet.whitespaces)
        let components = splitComponents.filter { !$0.isEmpty }.joined(separator: " ")
        splitComponents = components.components(separatedBy: "\n")
        for (index, line) in splitComponents.enumerated(){
            splitComponents[index] = line.trimmingCharacters(
                in: CharacterSet.whitespacesAndNewlines)
        }
        return splitComponents as NSArray
    }
}

extension searchListController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

extension searchListController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!, scope: "")
    }
}
