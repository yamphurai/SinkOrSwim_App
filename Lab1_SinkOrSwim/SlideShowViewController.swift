import UIKit

class SlideShowViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    // Array of images for the slideshow
    var flowerImages = [FlowerModel]()
    
    // Current image index
    var currentIndex = 0
    
    // Timer for the slideshow
    var slideshowTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        flowerImages = FlowerImageModel.instance.getFlowers()
        // Set the initial image
        imageView.image = flowerImages[currentIndex].image
        
        // Start the slideshow
        startSlideshow()
    }
    
    // MARK: - Slideshow Logic
    
    func startSlideshow() {
        // Set up the timer to change the image every 2 seconds
        slideshowTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(showNextImage), userInfo: nil, repeats: true)
    }
    
    @objc func showNextImage() {
        // Increment the index
        currentIndex += 1
        
        // If the index exceeds the number of images, reset to 0
        if currentIndex >= flowerImages.count {
            currentIndex = 0
        }
        
        // Update the image view with the next image
        imageView.image = flowerImages[currentIndex].image
        
        // Optional: Add a transition animation (fade effect)
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.fade
        imageView.layer.add(transition, forKey: nil)
    }
    
    // Stop the timer when the view disappears
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Invalidate the timer to stop the slideshow when leaving the view
        slideshowTimer?.invalidate()
        slideshowTimer = nil
    }
}
