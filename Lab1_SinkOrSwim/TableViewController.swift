//
//  TableViewController.swift
//  Lab1_SinkOrSwim
//
//  Created by Reshma Shrestha on 9/12/24.
//

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
       
        return 1
    }


    //method for number of rows in the table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.imageModel.imageNames.count
    }
    

    
    //identifier for resuable cell: "ImageNameCell"
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageNameCell", for: indexPath)

        //display the image name in specific row in table
        if let name = self.imageModel.imageNames[indexPath.row] as? String {
            cell.textLabel!.text = name
        }

        return cell
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
