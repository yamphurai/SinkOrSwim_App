//Class responsible for displaying a slideshow of flower images within a UIImageView

import UIKit

class SlideShowViewController: UIViewController {
    
    //connect to UIImageView in storyboard where images will be displayed
    @IBOutlet weak var imageView: UIImageView!
    
    //UILabel to show the flower image name
    @IBOutlet weak var flowerNameLabel: UILabel!
    
    // Array of images for the slideshow
    var flowerImages = [FlowerModel]()
    
    // Current image index i.e. first image for the slideshow
    //var currentIndex = 0
    
    // Timer for the slideshow
    var slideshowTimer: Timer?
    
    //array to keep track of displayed images
    private var shownImages = [Int]()
    
    
    //method to display random image
    override func viewDidLoad() {
            super.viewDidLoad()
            flowerImages = FlowerImageModel.instance.getFlowers()
            
            // Initialize the list of shown indices
            shownImages.removeAll()
            
            // Show a random image
            showRandomImage()
            
            // Start the slideshow
            startSlideshow()
        }

    /*
    override func viewDidLoad() {
        super.viewDidLoad()
        flowerImages = FlowerImageModel.instance.getFlowers()
        // Set the initial image
        imageView.image = flowerImages[currentIndex].image
        
        // Start the slideshow
        startSlideshow()
    }
     */
    
    // MARK: - Slideshow Logic
    
    func startSlideshow() {
        // Set up the timer to change the image every 2 seconds
        slideshowTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(showNextImage), userInfo: nil, repeats: true)
    }
    
    //to show random image
    @objc func showNextImage() {
        showRandomImage()
        /* Increment the index
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
         */
    }
    
    //method to show random image
    private func showRandomImage() {
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
        
            //to show image name
            let flower = flowerImages[randomIndex]
            imageView.image = flower.image
            flowerNameLabel.text = stripNumbers(from: flower.name)
            
            // Optional: Add a transition animation (fade effect)
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = CATransitionType.fade
            imageView.layer.add(transition, forKey: nil)
        }
    
    //helper method strip number from image names
    private func stripNumbers(from name: String) -> String {
        let pattern = "\\d+$"
        let regex = try? NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: name.utf16.count)
        let newName = regex?.stringByReplacingMatches(in: name, options: [], range: range, withTemplate: "")
        return newName ?? name
    }
    
    
    // Stop the timer when the view disappears
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Invalidate the timer to stop the slideshow when leaving the view
        slideshowTimer?.invalidate()
        slideshowTimer = nil
    }
}
