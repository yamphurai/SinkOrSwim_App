import UIKit

class GalleryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, FilterDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    // Filter Value
    var filter = "All"
        
    // Model Shared Instance
    lazy private var flowerImageModel = {
        return FlowerImageModel.instance
    }()
    
    // List Of Flowers
    private var filteredFlowers: [FlowerModel] = []
    
    // Default number of columns
    var numberOfColumns: Int = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Up Collection
        collectionView.dataSource = self
        collectionView.delegate = self
        
        filteredFlowers = flowerImageModel.getFlowers(forType: filter)
    }
    
    // Collection View Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredFlowers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCollectionViewCell else {
            fatalError("Could not dequeue ImageCollectionViewCell")
        }
            
        // Set the image for the imageView
         cell.imageView.image = filteredFlowers[indexPath.item].image
         return cell
    }
              
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 5
        let collectionViewWidth = collectionView.bounds.width
        
        let totalPadding = padding * CGFloat(numberOfColumns - 1) + (padding * 2)
        
        let availableWidth = collectionViewWidth - totalPadding
        let itemWidth = availableWidth / CGFloat(numberOfColumns)
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    // Function To Display Filter
    @IBAction func filterButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let filter = storyboard.instantiateViewController(withIdentifier: "GalleryFilterViewController") as? GalleryFilterViewController {
            filter.delegate = self
            present(filter, animated: true, completion: nil)
        }
    }
    
    // Delegate Method
    func didFilter(category: String?) {
        if let selectedCategory = category {
            filterGallery(category: selectedCategory)
        }
     }
    
    // Filter Gallery Based OnSelect
    func filterGallery(category : String) {
     
        if category == "All" {
            filteredFlowers = FlowerImageModel.instance.getFlowers()
        } else {
            filteredFlowers = FlowerImageModel.instance.getFlowers(forType:category)
        }
        
        // Reload the table view to show filtered results
        collectionView.reloadData()
    }
}


