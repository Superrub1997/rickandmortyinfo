//
//  Table.swift
//  RickAndMortyInfo
//
//  Created by MISO on 8/11/23.
//

import Foundation
import UIKit

// MARK: Characters table
extension ViewController : UITableViewDataSource, UITableViewDelegate {
    
    func loadTable(page: Page){
        self.currentPage = page
        table.dataSource = self
        table.delegate = self
        table.reloadData()
        table.rowHeight = 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currentPage?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentResult = self.currentPage?.results[indexPath.item]
        let cell = UITableViewCell()
        cell.backgroundColor = .white
        
        //Load character image
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        let imgURL = URL(string: currentResult?.image ?? "")
        if imgURL != nil {
            let task = URLSession.shared.dataTask(with: imgURL!) { data, response, error -> Void in
                if error != nil {
                    
                } else {
                    if let imgdata = data {
                        DispatchQueue.main.async {
                            img.image = UIImage(data: imgdata)
                        }
                    }
                }
            }
            task.resume()
        }
        
        //Create Label for name
        let label = UILabel()
        label.text = currentResult?.name
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textColor = .black
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        cell.contentView.addSubview(img)
        cell.addSubview(label)
        
        var constraints = [NSLayoutConstraint]()
        
        //Constraints for customs cell
        
        constraints.append(contentsOf: [
            img.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            img.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
            img.widthAnchor.constraint(equalToConstant: 100),
            img.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor)
        ])
        
        constraints.append(contentsOf: [
            label.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            label.leadingAnchor.constraint(equalTo: img.trailingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -40),
            label.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate(constraints)
        
        cell.layoutIfNeeded()
        
        return cell
    }
    
    //On touch
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentResult = self.currentPage?.results[indexPath.item]
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let charController = storyBoard.instantiateViewController(withIdentifier: "character") as! CharacterController
        charController.currentCharacter = currentResult
        self.present(charController, animated:true, completion:nil)
    }
}
