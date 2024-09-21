// Class responsible for displaying a slideshow of flower images within a UIImageView
import UIKit

class SlideShowViewController: UIViewController {
    
    //connect to UIImageView in storyboard where images will be displayed
    @IBOutlet weak var imageView: UIImageView!
    
    //UILabel to show the flower image name
    @IBOutlet weak var flowerNameLabel: UILabel!
    
    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var slideshowSwitch: UISwitch!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    // Array of images for the slideshow
    var flowerImages = [FlowerModel]()
    
    // Timer for the slideshow
    var slideshowTimer: Timer?
    
    // Timer Interval
    var timerInterval: Double = 2.0
    
    //array to keep track of displayed images
    var shownImages = [Int]()
        
    //method to display random image
    override func viewDidLoad() {
        super.viewDidLoad()
        flowerImages = FlowerImageModel.instance.getFlowers()
        
        // Add Speeds To Segmented Control
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "1x", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "2x", at: 1, animated: false)
        segmentedControl.insertSegment(withTitle: "5x", at: 2, animated: false)
            
        // Initialize the list of shown indices
        shownImages.removeAll()
            
        // Show a random image
        showNextImage()
        
        // Add Event To Switch Control
        slideshowSwitch.addTarget(self, action: #selector(toggleSlideshow), for: .valueChanged)
        
        // Start the slideshow
        startSlideshow(interval: timerInterval)
    }
  
    // Start Slide Show Using Interval
    func startSlideshow(interval: Double) {
        // Reset If Activce
        if slideshowTimer != nil {
            slideshowTimer?.invalidate()
            slideshowTimer = nil
        }
        slideshowTimer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(showNextImage), userInfo: nil, repeats: true)
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
            startSlideshow(interval: timerInterval)
        } else {
            stopSlideshow()
        }
    }
    
    // Change Timer Speed
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        let selectedSegmentIndex = sender.selectedSegmentIndex

        switch selectedSegmentIndex {
        case 0: //1x
            timerInterval = 2
        case 1: //2x
            timerInterval = 1
        case 2: //5x
            timerInterval = 0.5
        default:
            timerInterval = 2
        }
        
        startSlideshow(interval: timerInterval)
    }
    
    // Stop the timer when the view disappears
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopSlideshow()
    }
}
