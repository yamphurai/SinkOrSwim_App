//Manage & display list of flowers in table view, with filtering capabilities on a picker view.
//Class "FlowerListViewController" integrates both table view and picker view functionalities

import UIKit

class FlowerListViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    // Model Shared Instance
    lazy private var flowerImageModel = {
        return FlowerImageModel.instance
    }()
    
    // List Of Flowers that matches filter criteria
    private var filteredFlowers: [FlowerModel] = []
    
    // Get List Of Flower Types And Add All
    private var flowerTypes : [String]{
        return flowerImageModel.getflowerTypeFilter()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredFlowers = FlowerImageModel.instance.getFlowers()    // Initially show all flowers
    }
    
    // Table Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFlowers.count + 1      //one additional row for the picker view
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //dequeue pickercell
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PickerCell", for: indexPath) as? PickerTableViewCell {
                // Set the picker view delegate and data source
                cell.pickerView.delegate = self
                cell.pickerView.dataSource = self
                return cell
            } else {
                // Return an empty cell or handle the error
                return UITableViewCell()
            }
        //dequeue flowernamecell (flower names) for the rest of the rows
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FlowerNameCell", for: indexPath)
            if let flower = filteredFlowers[indexPath.row - 1] as FlowerModel? {
                cell.textLabel!.text = flower.name
            }
            return cell
        }
    }
    
    //Seque Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        //if the segue is to our ViewController as destination
        if let vc = segue.destination as? ViewController,
           let cell = sender as? UITableViewCell,
           let name = cell.textLabel?.text {
            vc.displayImageName = name
        }
    }
        
    // Picker Methods
    //return number of components/columns in picker view (i.e. 1 in our case)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //return number of rows in picker view (i.e. count of flower types)
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return flowerTypes.count
    }
    
    //provide title for each row of picker view (i.e. flower type)
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return flowerTypes[row]
    }
    
    // Filter List Based On Picker Selection. For "All", show all images. Otherwise, filter by selected type
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCategory = flowerTypes[row]
        
        if selectedCategory == "All" {
            filteredFlowers = FlowerImageModel.instance.getFlowers()
        } else {
            filteredFlowers = FlowerImageModel.instance.getFlowers(forType:selectedCategory)
        }
        
        // Reload the table view to show filtered results
        tableView.reloadData()
    }
}
