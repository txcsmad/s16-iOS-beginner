
import Foundation
import UIKit

class BuildingsCollectionViewController: UICollectionViewController {
    
    var buildings = [Building]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildings.append(Building(name: "Rockefeller Center", height: 850))
        buildings.append(Building(name: "The Chrysler Building", height: 1050))
        buildings.append(Building(name: "The Building", height: 1050))
        buildings.append(Building(name: "The Chrysler Building", height: 1050))
        buildings.append(Building(name: "The Chrysler Building", height: 1050))
        buildings.append(Building(name: "Rockefeller Center", height: 850))
        buildings.append(Building(name: "Rockefeller Center", height: 850))
        buildings.append(Building(name: "Rockefeller Center", height: 850))
        buildings.append(Building(name: "Rockefeller Center", height: 850))
        buildings.append(Building(name: "Rockefeller Center", height: 850))
        buildings.append(Building(name: "Rockefeller Center", height: 850))
        buildings.append(Building(name: "Rockefeller Center", height: 850))
        buildings.append(Building(name: "Rockefeller Center", height: 850))
        buildings.append(Building(name: "Rockefeller Center", height: 850))
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buildings.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("buildingCell", forIndexPath: indexPath) as! BuildingCell
        
        cell.imageView.image = buildings[indexPath.item].image
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailSegue" {
            if let item = collectionView?.indexPathsForSelectedItems()?.first?.item,
                detailsViewController = segue.destinationViewController as? BuildingDetailViewController {
                    detailsViewController.building = buildings[item]
            }
        }
    }
}


extension BuildingsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        if let image = buildings[indexPath.item].image {
            return CGSizeApplyAffineTransform(image.size, CGAffineTransformMakeScale(0.4, 0.4))
        }
        
        
        
        return CGSize(width: 40, height: 40)
    }
}
