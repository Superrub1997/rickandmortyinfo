//
//  ViewController.swift
//  RickAndMortyInfo
//
//  Created by MISO on 8/11/23.
//

import UIKit

class ViewController: UIViewController {

    var currentPage: Page?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load JSON and table
        loadPage(number: 1, urlString: "https://rickandmortyapi.com/api/character")
        search.backgroundColor = .white
        search.barTintColor = .white

        
    }
    // MARK: IBoutlets

    @IBOutlet weak var table: UITableView!
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue){
        print("bye")
    }
    
    @IBOutlet weak var nextPage: UIButton!
    @IBOutlet weak var previous: UIButton!
    @IBOutlet weak var pageNumber: UILabel!
    @IBOutlet weak var search: UISearchBar!
    @IBAction func toNextPage(_ sender: UIButton) {
        let url = self.currentPage?.info.next
        let split = url?.components(separatedBy: "=")
        var number = 1
        if split?.count != 1 {
            //according to the API and the request, page number goes after the first =
            if let second = split?[1] {
                //split if search is used
                if second.contains("&") {
                    let split2 = second.components(separatedBy: "&")
                    number = Int(split2[0]) ?? 1
                } else {
                    number = Int(second) ?? 1
                }
            }
        }
        loadPage(number: number, urlString: url ?? "")
    }
    
    @IBAction func toPrevPage(_ sender: UIButton) {
        let url = self.currentPage?.info.prev
        let split = url?.components(separatedBy: "=")
        var number = 1
        if split?.count != 1 {
            //according to the API and the request, page number goes after the first =
            if let second = split?[1] {
                //split if search is used
                if second.contains("&") {
                    let split2 = second.components(separatedBy: "&")
                    number = Int(split2[0]) ?? 1
                } else {
                    number = Int(second) ?? 1
                }
            }
        }
        loadPage(number: number, urlString: url ?? "")
    }
    
    // MARK: Aux Funcs
    
    func loadPage(number: Int, urlString: String){
        guard let url = URL(string: urlString) else { return }
        var json = ""
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) -> Void in
            if error != nil {
                json = ""
            } else {
                if let jsondata = data {
                    if let jsonString = String(data: jsondata, encoding: .utf8) {
                        json = jsonString
                        let decoder = JSONDecoder()

                        let jsonData = Data(json.utf8)
                        DispatchQueue.main.async {
                            do {
                                let page = try decoder.decode(Page.self, from: jsonData)
                                self.currentPage = page
                                self.pageNumber.text = "Page " + String(number)
                                if number == 1 {
                                    self.previous.isEnabled = false
                                } else {
                                    self.previous.isEnabled = true
                                }
                                if number == page.info.pages {
                                    self.nextPage.isEnabled = false
                                } else {
                                    self.nextPage.isEnabled = true
                                }
                                self.loadTable(page: page)
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    }
                }
            }
        }
        task.resume()
    }
}

