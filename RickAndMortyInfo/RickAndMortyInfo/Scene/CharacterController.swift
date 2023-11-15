//
//  CharacterController.swift
//  RickAndMortyInfo
//
//  Created by MISO on 8/11/23.
//

import Foundation
import UIKit

class CharacterController: UIViewController {
    
    var currentCharacter : Character?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = currentCharacter?.name
        info.text = currentCharacter?.status
        if currentCharacter?.status == "Alive" {
            info.textColor = .green
        } else if currentCharacter?.status == "Dead" {
            info.textColor = .red
        }
        location.text = "Latest location:"
        locationName.text = currentCharacter?.location.name ?? "Unknown"
        species.text = (currentCharacter?.gender ?? "Unknown") + " - " + (currentCharacter?.species ?? "Unknown")
        //Load img
        let imgURL = URL(string: currentCharacter?.image ?? "")
        if imgURL != nil {
            let task = URLSession.shared.dataTask(with: imgURL!) { data, response, error -> Void in
                if error != nil {
                    
                } else {
                    if let imgdata = data {
                        DispatchQueue.main.async {
                            self.img.image = UIImage(data: imgdata)
                        }
                    }
                }
            }
            task.resume()
        }
        
        //Load episode
        let episodeURL = URL(string: currentCharacter?.episode[0] ?? "")
        if episodeURL != nil {
            let task = URLSession.shared.dataTask(with: episodeURL!) { data, response, error -> Void in
                if error != nil {
                    
                } else {
                    var json = ""
                    if let jsondata = data {
                        if let jsonString = String(data: jsondata, encoding: .utf8) {
                            json = jsonString
                            let decoder = JSONDecoder()
                            
                            let jsonData = Data(json.utf8)
                            DispatchQueue.main.async {
                                do {
                                    let episode = try decoder.decode(Episode.self, from: jsonData)
                                    self.episode.text = episode.name
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
    
    // MARK: IBOutlets
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var species: UILabel!
    @IBOutlet weak var episode: UILabel!
}
