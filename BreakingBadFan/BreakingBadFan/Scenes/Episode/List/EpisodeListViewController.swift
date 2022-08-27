

import Foundation
import UIKit

class EpisodeListViewController: UIViewController {
    let apiManager = APIManager()
    
    @IBOutlet weak var filterButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    var seasons = [Season]()
    var episodes = [Episode]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIAppSettings.roundCorners(of: filterButton, by: 10)
        UIAppSettings.setButtonColor(button: filterButton, color: .purple)
        configureCell()
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
            let season = Season(title: episode.season, episodes: [])
            seasons.append(season)
        }
        seasons = Array(Set(seasons))
        seasons.sort()
 
        for episode in episodes {
            
            if let seasonIndex = seasons.firstIndex(where: {
                $0.title == episode.season}) {
                seasons[seasonIndex].episodes.append(episode)
            }
            //TODO: - somehow to sort by  alpha.
            self.episodes.sort()
        }
    }
    
    
    
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func configureCell () {
        
        let cellNib = UINib(nibName: "EpisodeCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "EpisodeCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension EpisodeListViewController: UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeCell",
                                                 for: indexPath)
        guard let episodeCell = cell as? EpisodeCell else {
            return cell
        }
        
        episodeCell.configureCell(episodeTitle: seasons[indexPath.section].episodes[indexPath.row].title)
        return episodeCell
    }
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return seasons.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seasons[section].episodes.count
    }
        
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "SEASON: \(seasons[section].title)"
    }

}

extension EpisodeListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("didSelectRowAt")
        let episodeDetailsScene = EpisodeDetailsViewController()
        present(episodeDetailsScene, animated: true, completion: nil)
    }
}



