import UIKit

// Similar Concept To Flip Model Assignment Converted To Swift
// Class for singleton patter: Model Lazy Loads Photos And Has Methods To Access The Photos By Name, Category, etc.
class FlowerImageModel {

    // Force Singleton Pattern ensuring that all parts of the app access the same image data
    private init() {}
    
    // Shared/Singleton Instance
    static let instance = FlowerImageModel()
    
    // Private List Of Static Values (i.e. static list of flowers). Used In Lieu Of Database.
    private lazy var flowers: [FlowerModel] = {
        var flowersList = [FlowerModel]()
        
        flowersList.append(FlowerModel(name: "Daisy 1", type: "Daisy", image: loadImage(named: "Daisy_1")))
        flowersList.append(FlowerModel(name: "Daisy 2", type: "Daisy", image: loadImage(named: "Daisy_2")))
        flowersList.append(FlowerModel(name: "Daisy 3", type: "Daisy", image: loadImage(named: "Daisy_3")))
        flowersList.append(FlowerModel(name: "Daisy 4", type: "Daisy", image: loadImage(named: "Daisy_4")))
        flowersList.append(FlowerModel(name: "Daisy 5", type: "Daisy", image: loadImage(named: "Daisy_5")))

        flowersList.append(FlowerModel(name: "Dandelion 1", type: "Dandelion", image: loadImage(named: "Dandelion_1")))
        flowersList.append(FlowerModel(name: "Dandelion 2", type: "Dandelion", image: loadImage(named: "Dandelion_2")))
        flowersList.append(FlowerModel(name: "Dandelion 3", type: "Dandelion", image: loadImage(named: "Dandelion_3")))
        flowersList.append(FlowerModel(name: "Dandelion 4", type: "Dandelion", image: loadImage(named: "Dandelion_4")))
        flowersList.append(FlowerModel(name: "Dandelion 5", type: "Dandelion", image: loadImage(named: "Dandelion_5")))

        flowersList.append(FlowerModel(name: "Rose 1", type: "Rose", image: loadImage(named: "Rose_1")))
        flowersList.append(FlowerModel(name: "Rose 2", type: "Rose", image: loadImage(named: "Rose_2")))
        flowersList.append(FlowerModel(name: "Rose 3", type: "Rose", image: loadImage(named: "Rose_3")))
        flowersList.append(FlowerModel(name: "Rose 4", type: "Rose", image: loadImage(named: "Rose_4")))
        flowersList.append(FlowerModel(name: "Rose 5", type: "Rose", image: loadImage(named: "Rose_5")))

        flowersList.append(FlowerModel(name: "Sunflower 1", type: "Sunflower", image: loadImage(named: "Sunflower_1")))
        flowersList.append(FlowerModel(name: "Sunflower 2", type: "Sunflower", image: loadImage(named: "Sunflower_2")))
        flowersList.append(FlowerModel(name: "Sunflower 3", type: "Sunflower", image: loadImage(named: "Sunflower_3")))
        flowersList.append(FlowerModel(name: "Sunflower 4", type: "Sunflower", image: loadImage(named: "Sunflower_4")))
        flowersList.append(FlowerModel(name: "Sunflower 5", type: "Sunflower", image: loadImage(named: "Sunflower_5")))

        flowersList.append(FlowerModel(name: "Tulip 1", type: "Tulip", image: loadImage(named: "Tulip_1")))
        flowersList.append(FlowerModel(name: "Tulip 2", type: "Tulip", image: loadImage(named: "Tulip_2")))
        flowersList.append(FlowerModel(name: "Tulip 3", type: "Tulip", image: loadImage(named: "Tulip_3")))
        flowersList.append(FlowerModel(name: "Tulip 4", type: "Tulip", image: loadImage(named: "Tulip_4")))
        flowersList.append(FlowerModel(name: "Tulip 5", type: "Tulip", image: loadImage(named: "Tulip_5")))
                           
        return flowersList
    }()
    
    // Private List Of Static Flower Type Values. Used In Lieu Of Database.
    private lazy var flowerTypes: [String] = {
        return ["Daisy", "Dandelion", "Rose", "Sunflower", "Tulip"]
    }()
    
    // Helper To Load Image if the "imageName" exists
    private func loadImage(named imageName: String) -> UIImage {
        guard let image = UIImage(named: imageName) else {
            fatalError("Image named \(imageName) could not be found")
        }
        return image
    }
    
    // Return List Of All Flowers Images
    func getFlowers() -> [FlowerModel] {
        return self.flowers
    }
    
    // Return Count Of Flowers Images
    func getFlowerCount() -> Int {
        return self.flowers.count
    }
    
    // Return List Of All Flower Types
    func getFlowerTypes() -> [String] {
        return self.flowerTypes
    }
    
    // Return Count Of Flower Types
    func getFlowerTypeCount() -> Int{
        return self.flowerTypes.count
    }
    
    // Get List Of Flower Types And Add All
    func getflowerTypeFilter() -> [String]{
        var types = self.flowerTypes
        types.insert("All", at:0)
        return types
    }
    
    // Return List Of All Flowers Filtered By Type
    func getFlowers(forType type: String) -> [FlowerModel] {
        if type == "All" {
            return self.flowers
        }
        else {
            return self.flowers.filter { $0.type == type }
        }
    }
    
    // Return Flower By Index
    func getFlowerByIndex(index: Int) -> FlowerModel? {
        if index < 0 || index >= self.flowers.count {
            fatalError("Index \(index) Is Not Valid")
        }
        
        let flower = self.flowers[index]
        return flower
    }
    
    // Return Flower By Name. If More Than One, Show The First One
    //This will always return the same image (the first one)? Maybe want to pick random flower image of same name? --> Jee
    
    func getFlowerByName(name: String) -> FlowerModel? {
        // Find all flowers with the given name
        let matchingFlowers = self.flowers.filter { $0.name == name }
        
        // Check if there are any matching flowers
        if !matchingFlowers.isEmpty {
            // Return a random flower from the matching flowers
            let randomIndex = Int.random(in: 0..<matchingFlowers.count)
            return matchingFlowers[randomIndex]
        } else {
            // If no matching flowers are found, trigger a fatal error
            fatalError("Cannot Find Image For Name: \(name)")
        }
    }
    
    // Return Random Flower
    func getRandomFlower() -> FlowerModel? {
        let randomNumber = Int.random(in: 0...(self.flowers.count - 1))
        return self.getFlowerByIndex(index: randomNumber)
   }
}
