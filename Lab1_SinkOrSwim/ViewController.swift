//Sink or Swim app
//Team member: Arman, Clifton, Jeevan


import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    //lazily instantiate the "imageModel"
    lazy var imageModel = {
        return ImageModel.sharedInstance()
    }()
    
    //instantiate "imageView" that return UIImageView
    lazy private var imageView: UIImageView? = {
        
        //display the image based on the name
        return UIImageView.init(image: self.imageModel.getImageWithName(displayImageName))
    }()
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var displayImageName = "AfricanMarigold"
    
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

