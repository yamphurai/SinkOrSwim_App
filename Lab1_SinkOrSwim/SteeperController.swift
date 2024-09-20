//Manage & display list of flowers in table view, with filtering capabilities on a picker view.
//Class "FlowerListViewController" integrates both table view and picker view functionalities

import UIKit

class SteeperController: UIViewController{
    
    @IBOutlet weak var count: UILabel!
   
    @IBOutlet weak var stepper: UIStepper!
    
    @IBOutlet weak var countLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        stepper.stepValue = 1
        
    }
    @IBAction func stepperAction(_ sender: UIStepper) {
        count.text = Int(sender.value).description
    }
}
