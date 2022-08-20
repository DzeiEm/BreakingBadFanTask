
import Foundation
import UIKit

class UIAppSettings {
    
    static func roundCorners(of button: UIButton, by: Int) {
        button.layer.cornerRadius = CGFloat(by)
    }
    
    static func setButtonColor(button: UIButton, color: UIColor) {
        button.backgroundColor = color
    }
    
    static func hightlight(textfield: UITextField, by color: UIColor) {
        
    }
    
}
