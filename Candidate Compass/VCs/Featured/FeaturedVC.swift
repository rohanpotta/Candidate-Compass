import UIKit
import SafariServices

class FeaturedVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    private let tableView: UITableView = {
       let table = UITableView()
       table.register(FeaturedTableViewCell.self, forCellReuseIdentifier: FeaturedTableViewCell.identifier)
       return table
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()
    
    private var originalArticles: [Article] = []
    private var filteredArticles: [Article] = []
    private var viewModels = [FeaturedTableViewCellModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Featured News"
        view.addSubview(tableView)
        view.addSubview(searchBar)
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        searchBar.placeholder = "Search for any Topic..."
        view.backgroundColor = .systemBackground
        fetchTopStories()
        setupConstraints()
        searchBar.isEnabled = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredArticles = originalArticles
        } else {
            filteredArticles = originalArticles.filter { item in
                return item.title.lowercased().contains(searchText.lowercased())
            }
        }
        self.tableView.reloadData()
    }
    
    private func fetchTopStories() {
        FeaturedAPICaller.shared.getTopStories { [weak self] result in
            switch result {
            case .success(let articles):
                self?.originalArticles = articles
                self?.viewModels = articles.compactMap({
                    FeaturedTableViewCellModel(title: $0.title, subtitle: $0.description ?? "No Description", imageURL: URL(string: $0.urlToImage ?? ""))
                })

                self?.filteredArticles = articles
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.searchBar.isEnabled = true
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func tableView(  _ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeaturedTableViewCell.identifier, for: indexPath) as? FeaturedTableViewCell else {
            fatalError()
        }
        
        let article = filteredArticles[indexPath.row]
        cell.configure(with: FeaturedTableViewCellModel(title: article.title, subtitle: article.description ?? "No Description", imageURL: URL(string: article.urlToImage ?? "")))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = filteredArticles[indexPath.row] 
        
        guard let url = URL(string: article.url ?? "") else {
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    func tableView(  _ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    private func setupConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 56),

            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
