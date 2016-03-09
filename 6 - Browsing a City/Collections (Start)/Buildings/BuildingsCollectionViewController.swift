
import Foundation
import UIKit

class BuildingsCollectionViewController: UICollectionViewController {
    
    var buildings = [Building]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildings.append(Building(name: "The Empire State Building", height: 1250))
        buildings.append(Building(name: "Rockefeller Center", height: 850))
        buildings.append(Building(name: "The Chrysler Building", height: 1050))
        buildings.append(Building(name: "The Flatiron Building", height: 285))
    }
}