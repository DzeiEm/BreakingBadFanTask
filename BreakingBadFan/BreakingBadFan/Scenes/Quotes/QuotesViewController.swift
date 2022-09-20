

import Foundation
import UIKit


enum Header: String {
    case quote = "Quote"
}

class QuotesViewController: UIViewController {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    let apiManager = APIManager()
    var parsedQuotes = [Quote]()
    var header: String?
    var author: String?
    var birthdayDate: String?
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCell()
        apiManager.getQuotes(completion: { [weak self] result in
            switch result {
            case.failure(let error):
                print("ERROR fetching quates: \(error)")
            case .success(var quotes):
                print("QUOTES: \(quotes)")
                self?.setQuotes(quotes)
                DispatchQueue.main.async {
                    self?.setLabels()
                    self?.tableView.reloadData()
                }
            }
        })
        setupTableView()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 55
    }
    
    func setQuotes(_ quotes: [Quote]) {
        print("QUOTES: \(quotes)")
        self.parsedQuotes = quotes
    }
    
    func configureCell() {
        let cellNib = UINib(nibName: "QuoteCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "QuoteCell")
    }
    
    func setLabels() {
   // TODO: - does not working
    }
}

extension QuotesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parsedQuotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteCell", for: indexPath)
        
        guard let quotesCell = cell as? QuoteCell else {
            return cell
        }
        quotesCell.configureCell(title: parsedQuotes[indexPath.row].header)
        return quotesCell
    }
}

extension QuotesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tapped")
    }
}
