//
//  Search.swift
//  RickAndMortyInfo
//
//  Created by MISO on 13/11/23.
//

import Foundation
import UIKit

// MARK: Search
extension ViewController : UISearchBarDelegate {
    
    //Reload the table based on the results of the searchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let url = "https://rickandmortyapi.com/api/character/?name=" + searchText
        self.loadPage(number: 1, urlString: url)
    }
}
