
import Foundation
import UIKit

class LoaderActivityIndicator: UIViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError(" something in loader")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue.withAlphaComponent(0.7)
    }
    
    static func showLoader(from viewController: UIViewController) {
        let indicatorViewController = LoaderActivityIndicator(nibName:nil, bundle: nil)
        viewController.present(indicatorViewController, animated: true)
    }
    
    static func hideLoader(from viewController: UIViewController) {
        if let indicatorViewController = viewController.presentedViewController as?  LoaderActivityIndicator {
            indicatorViewController.dismiss(animated: false)
        }
        
    }
  
    
}
