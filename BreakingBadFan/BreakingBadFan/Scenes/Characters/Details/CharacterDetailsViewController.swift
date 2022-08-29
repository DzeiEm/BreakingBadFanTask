
import Foundation
import UIKit

class CharacterDetailsViewController : UIViewController {
    
    @IBOutlet weak var characterIDLabel: UILabel!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterBirthdayLabel: UILabel!
    @IBOutlet weak var characterOccupationLabel: UILabel!
    
    @IBOutlet weak var characterStatusLabel: UILabel!
    @IBOutlet weak var characterAppearanceLabel: UILabel!
    @IBOutlet weak var characterNicknameLabel: UILabel!
    @IBOutlet weak var characterPortrayedLabel: UILabel!
    
    var id: String? = ""
    var name: String? = ""
    var birthday: String? = ""
    var occupation: [String] = []
    var status: String? = ""
    var appearance: [Int] = []
    var nickname: String? = ""
    var portrayed: String? = ""
    
    
    override func viewDidLoad() {
        setLabelValues()
    }
    
    func setLabelValues() {
        
        if let id = id {
            characterIDLabel.text = "ID: \(id)"
        }
        
        if let name = name {
            characterNameLabel.text = "Name: \(name)"
        }
        
        if let nickname = nickname {
            characterNicknameLabel.text = "Nickname: \(nickname)"
        }
        
        if let birthday = birthday {
            characterBirthdayLabel.text = "Birthday: \(birthday)"
        }
        
        if let portrayed = portrayed {
            characterPortrayedLabel.text = "Portrayed: \(portrayed)"
        }
        
        if let status = status {
            characterStatusLabel.text = "Status: \(status.description)"
        }
        
        characterOccupationLabel.text = "Occupation: \(occupation.description)"
        characterAppearanceLabel.text = "Appearance: \(appearance.description)"
    }
}
