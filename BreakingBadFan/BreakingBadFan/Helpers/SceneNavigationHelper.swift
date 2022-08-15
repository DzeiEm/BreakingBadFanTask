
import Foundation
import UIKit

class SceneNavigationHelper: UIViewController {
    
    var profileManager = ProfileManager()
    
    static func navigate(mainController: UIViewController, to: UIViewController) {
     
        let mainController = mainController
        mainController.profileManager = profileManager
        
       
    }
    
}
