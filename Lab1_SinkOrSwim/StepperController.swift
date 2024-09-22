import UIKit

 class SteeperController: UIViewController{

     @IBOutlet weak var stepper: UIStepper!
     
     @IBOutlet weak var likeLabel: UILabel!
     

     @IBOutlet weak var likeCount: UILabel!
     
     override func viewDidLoad() {
         super.viewDidLoad()
         stepper.stepValue = 1

     }
     @IBAction func stepper(_ sender: UIStepper) {
         likeCount.text = Int(sender.value).description
     }
 }
