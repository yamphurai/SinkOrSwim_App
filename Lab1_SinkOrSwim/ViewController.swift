//Sink or Swim app
//Team member: Arman, Clifton, Jeevan


import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    
    // Name Of Image TO Display
    var displayImageName = ""
    
    // Model Shared Instance
    lazy private var flowerImageModel = {
        return FlowerImageModel.instance
    }()
    
    //instantiate "imageView" that return UIImageView
    lazy private var imageView: UIImageView? = {
        
        //display the image based on the name
        return UIImageView.init(image: self.flowerImageModel.getFlowerByName(name: displayImageName)?.image)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //set the size of the scroll = size of the image
        if let size = self.imageView?.image?.size{
            self.scrollView.addSubview(self.imageView!)  //add imageView as a subset of scroll view
            self.scrollView.contentSize = size
            self.scrollView.minimumZoomScale = 0.1      //zoom to 10% of the image size
            self.scrollView.delegate = self
        }
    }
    
    //function to enable zooom functionality
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    



}

