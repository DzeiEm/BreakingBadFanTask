
import Foundation
import UIKit

class EpisodeListViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    @IBOutlet private weak var filterButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    let apiManager = APIManager()
    var seasons = [Season]()
    var episodes = [Episode]()
    let filterController = EpisodeFilterPopoverViewController()
    
    //MARK: - ACTIONS
    @IBAction func filterButtonTapped(_ sender: Any) {
        navigate(to: filterController)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonView()
        configureCell()
        fetchEpisodes()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 55
    }
    
    func setButtonView() {
        UIAppSettings.roundCorners(of: filterButton, by: 10)
        UIAppSettings.setButtonColor(button: filterButton, color: .purple)
    }
    
    func configureCell() {
        let cellNib = UINib(nibName: "EpisodeCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "EpisodeCell")
    }
    
    func fetchEpisodes() {
        apiManager.getEpisodes(completion: { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let episodes):
                self?.mapEpisodesToSeasons(episodes: episodes)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                print(episodes)
            }
        })
    }
    
    func mapEpisodesToSeasons(episodes: [Episode]) {
        for episode in episodes {
            let season = Season(title: episode.season, episodes: [])
            seasons.append(season)
        }
        seasons = Array(Set(seasons))
        
        for episode in episodes {
            if let seasonIndex = seasons.firstIndex(where: {
                $0.title == episode.season}) {
                seasons[seasonIndex].episodes.append(episode)
            }
        }
        sortSeasons()
    }
    
    func sortSeasons() {
        self.seasons =  seasons.sorted { $0.title < $1.title }
        for i in seasons.indices {
            let filteredSeason =  seasons[i].episodes.sorted { $0.title < $1.title }
            seasons[i].episodes = filteredSeason
        }
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
        seasons.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        seasons[section].episodes.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "SEASON: \(seasons[section].title)"
    }
}

extension EpisodeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let episode = seasons[indexPath.section].episodes[indexPath.row]
        let episodeDetails = EpisodeDetailsViewController()
        episodeDetails.episodeNo = String(episode.id)
        episodeDetails.episodeTitle = episode.title
        episodeDetails.seasonNo = episode.season
        episodeDetails.date = episode.airDate
        episodeDetails.characters = episode.characters
        
        let episodeDetailsViewController = EpisodeDetailsViewController()
        episodeDetailsViewController.modalPresentationStyle = .fullScreen
        present(episodeDetails, animated: true, completion: nil)
    }
}

//TODO: POPOVER ??????
extension EpisodeListViewController {
    func displayPopover() {
        //        let controller = UIAlertController(title: "Controller", message: "Message for controlleer", preferredStyle: .alert)
        let filterController = EpisodeFilterPopoverViewController()
        let pop = filterController.popoverPresentationController
        //        let popover = controller.popoverPresentationController
        pop?.sourceView = view
        pop?.sourceRect = CGRect(x: 32, y: 32, width: 64, height: 64)
        present(filterController, animated: true, completion: nil)
    }
    //    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
    //        return .none
    //    }
    
    func navigate(to controller: UIViewController) {
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
    }
}




