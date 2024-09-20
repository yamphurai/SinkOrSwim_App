// Class responsible for displaying a slideshow of flower images within a UIImageView
import UIKit

class SlideShowViewController: UIViewController {
    
    //connect to UIImageView in storyboard where images will be displayed
    @IBOutlet weak var imageView: UIImageView!
    
    //UILabel to show the flower image name
    @IBOutlet weak var flowerNameLabel: UILabel!
    
    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var slideshowSwitch: UISwitch!

    // Array of images for the slideshow
    var flowerImages = [FlowerModel]()
    
    // Timer for the slideshow
    var slideshowTimer: Timer?
    
    //array to keep track of displayed images
    var shownImages = [Int]()
        
    //method to display random image
    override func viewDidLoad() {
        super.viewDidLoad()
        flowerImages = FlowerImageModel.instance.getFlowers()
            
        // Initialize the list of shown indices
        shownImages.removeAll()
            
        // Show a random image
        showNextImage()
        
        // Add Event To Switch Control
        slideshowSwitch.addTarget(self, action: #selector(toggleSlideshow), for: .valueChanged)
        
        // Start the slideshow
        startSlideshow()
    }
  
    func startSlideshow() {
        // Set up the timer to change the image every 2 seconds
        slideshowTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(showNextImage), userInfo: nil, repeats: true)
        switchLabel.text = "Stop Show"
    }
    
    // Stop Slide Show
    func stopSlideshow() {
        slideshowTimer?.invalidate()
        slideshowTimer = nil
        switchLabel.text = "Start Show"
    }
    
    //to show random image
    @objc func showNextImage() {
        var imageIndex = getRandomImageIndex()
        showImage(imageIndex: imageIndex)
    }
    
    // Display Image And Label
    func showImage(imageIndex : Int) {
        
        // If Bad Param, Show First Image
        if imageIndex >= flowerImages.count {
            let imageIndex = 0
        }
        
        //to show image name
        let flower = flowerImages[imageIndex]
        imageView.image = flower.image
        flowerNameLabel.text = flower.type
        
        // Optional: Add a transition animation (fade effect)
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.fade
        imageView.layer.add(transition, forKey: nil)
    }
    
    // Get Random Image Index
    func getRandomImageIndex() -> Int {
        // Check if all images have been shown
        if shownImages.count == flowerImages.count {
            // Reset shown indices if all images have been shown
            shownImages.removeAll()
        }
        
        // Select a random image that hasn't been shown yet
        var randomIndex: Int
        repeat {
            randomIndex = Int.random(in: 0..<flowerImages.count)
        } while shownImages.contains(randomIndex)
        
        // Mark this image as shown
        shownImages.append(randomIndex)
        
        return randomIndex
    }
      
    // Turn Slide Show On And Off
    @objc func toggleSlideshow(_ sender: UISwitch) {
        if sender.isOn {
            startSlideshow()
        } else {
            stopSlideshow()
        }
    }
    
    // Stop the timer when the view disappears
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopSlideshow()
    }
}
