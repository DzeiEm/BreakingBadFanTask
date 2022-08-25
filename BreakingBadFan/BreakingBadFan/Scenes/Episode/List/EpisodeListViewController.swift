

import Foundation
import UIKit

class EpisodeListViewController: UIViewController {
    let apiManager = APIManager()
    
    
    @IBOutlet weak var tableView: UITableView!
    var seasons = [Season]()
    var episodes = [Episode]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiManager.getEpisodes(completion: { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
                
            case .success(let episodes):
                self?.mapEpisodesToSeasons(episodes: episodes)
                //TODO
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
                print(episodes)
            }
        })
        setupTableView()
    }
    
    func mapEpisodesToSeasons(episodes: [Episode]) {
        
        for episode in episodes {
            let season = Season(title: episode.title,
                                episodes: [])
            seasons.append(season)
        }
        seasons = Array(Set(seasons))
        
        for episode in episodes {
            let episode = Episode(id: episode.id,
                                  title: episode.title,
                                  season: episode.season,
                                  airDate: episode.airDate,
                                  characters: episode.characters)
            self.episodes.append(episode)
        }
        
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
        //TODO . 1.view new 2. priregistruoti celle viewdidload. tvarkau miesta app Problems view controller, problem cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeCell")! as UITableViewCell
        cell.textLabel?.text = seasons[indexPath.row].title
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
        print("didSelectRowAt")
    }
}



