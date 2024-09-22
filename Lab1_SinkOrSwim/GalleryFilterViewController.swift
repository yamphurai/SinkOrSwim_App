import UIKit

// Delegate To Communicate Back To Caller
protocol FilterDelegate: AnyObject {
    func didFilter(category: String?)
}

class GalleryFilterViewController: UITableViewController {

    weak var delegate: FilterDelegate?

    // Model Shared Instance
    lazy private var flowerImageModel = {
        return FlowerImageModel.instance
    }()
        
    // Get List Of Flower Types And Add All
    lazy private var flowerTypes = {
        return flowerImageModel.getflowerTypeFilter()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Table Functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flowerTypes.count + 2
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
            return cell
        }
        else if indexPath.row < (flowerTypes.count + 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FlowerTypeCell", for: indexPath)
            cell.textLabel?.text = flowerTypes[indexPath.row - 1]
            return cell
        }
       else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CancelCell", for: indexPath)
            return cell
        }
    }
    
    // Add Click Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var rowCount = tableView.numberOfRows(inSection: 0)
        rowCount = rowCount - 1
        if !(indexPath.row == 0 || indexPath.row == rowCount) {
            var index = indexPath.row - 1
            let selectedCategory = flowerTypes[index]
            delegate?.didFilter(category: selectedCategory)
            dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
