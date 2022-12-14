
import Foundation
import UIKit

class CharacterViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    let apiManager = APIManager()
    var parsedCharacters = [Character]()
    
    override func viewDidLoad() {
        configureCell()
        fetchCharacters()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 65
    }
    
    func configureCell() {
        let cellNib = UINib(nibName: "CharacterCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "CharacterCell")
    }
    
    func fetchCharacters() {
        apiManager.getCharacters(completion: { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let characters):
                self?.setCharacters(characters)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                print(characters)
            }
        })
    }
    
    func setCharacters(_ characters: [Character]) {
        parsedCharacters  = characters
    }
}

extension CharacterViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parsedCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath)
        
        guard let characterCell = cell as? CharacterCell else {
            return cell
        }
        characterCell.configureCell(title: parsedCharacters[indexPath.row].name)
        return characterCell
    }
}

extension CharacterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let characterDetailsViewController = CharacterDetailsViewController()
        let charactersList = parsedCharacters[indexPath.section]
        characterDetailsViewController.id = String(charactersList.id)
        characterDetailsViewController.name = charactersList.name
        characterDetailsViewController.birthday = charactersList.birthday
        characterDetailsViewController.occupation = charactersList.occupation
        characterDetailsViewController.status = charactersList.status.description
        characterDetailsViewController.appearance = charactersList.appearance
        characterDetailsViewController.nickname = charactersList.nickname
        characterDetailsViewController.portrayed = charactersList.portrayed
        
        characterDetailsViewController.modalPresentationStyle = .fullScreen
        present(characterDetailsViewController, animated: true, completion: nil)
    }
}
