

import Foundation
import UIKit

class EpisodeListViewController: UIViewController {
    let apiManager = APIManager()
    
    var tableView: UITableView!
    var seasons = [Season]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        apiManager.getEpisodes(completion: { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
                
            case .success(let episodes):
                self?.mapEpisodesToSeasons(episodes: episodes)
                //TODO
                self?.tableView.reloadData()
                print(episodes)
            }
        })
        setupTableView()
    }
    
    func mapEpisodesToSeasons(episodes: [Episode]) {
        
       
        
    }
    
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
}


extension EpisodeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seasons[section].episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeCell")! as UITableViewCell
                cell.textLabel?.text = "Something"
                return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return seasons.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return seasons[section].title
    }

}
extension EpisodeListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print()
    }
}



