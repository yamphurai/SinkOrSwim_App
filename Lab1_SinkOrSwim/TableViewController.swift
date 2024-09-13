//Sink or Swim app
//Team members: Arman, Clifton, Jeevan

import UIKit

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    //handle the imageModel
    lazy var imageModel: ImageModel = {
        return ImageModel.sharedInstance()
    }()

    // MARK: - Table view data source

    
    //method for number of sections in the table
    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 3
    }


    //method for number of rows in the table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //return number of rows based on the selected cell. If first section, #rows=# of images, otherwise it's 1
        if section == 0{
            return self.imageModel.imageNames.count
        }
        return 1
    }
    

    
    //identifier for resuable cell: "ImageNameCell"
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //display the image with details once user clicks the cell. if first section is selected
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageNameCell", for: indexPath)
            if let name = self.imageModel.imageNames[indexPath.row] as? String {
                cell.textLabel!.text = name
            }
            return cell
            
        //if second cell is selected
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageDetail", for: indexPath)
            cell.textLabel?.text = "All Images"
            cell.detailTextLabel?.text = "Details"
            return cell
        
        //if third cell is selected
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageBySeason", for: indexPath)
            cell.textLabel?.text = "Flower by season"
            return cell
        }
    }
    

    //segue from selected row to show specific image
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //if the segue is to our ViewController as destination
        if let vc = segue.destination as? ViewController,
           let cell = sender as? UITableViewCell,
           let name = cell.textLabel?.text {
            vc.displayImageName = name
        }
    }
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
