import UIKit
import SafariServices

class ForYouVideosVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var keyword: String?
    private var videoItems = [VideoItem]()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(ForYouVideosTableViewCell.self, forCellReuseIdentifier: ForYouVideosTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Latest News"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
        
        fetchVideos()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func fetchVideos() {
        YoutubeAPIResponse.shared.getVideos(keyword: keyword!) { [weak self] result in
            switch result {
                case .success(let fetchedVideoItems):
                    self?.videoItems = fetchedVideoItems
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoItems.count
    }
    
    func convertISO8601ToDateFormattedString(iso8601DateString: String, outputFormat: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let iso8601Date = dateFormatter.date(from: iso8601DateString) {
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = outputFormat
            
            return outputDateFormatter.string(from: iso8601Date)
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ForYouVideosTableViewCell.identifier, for: indexPath) as! ForYouVideosTableViewCell
        let videoItem = videoItems[indexPath.row]
        
        cell.titleLabel.text = videoItem.snippet.title.htmlDecoded
        let iso8601DateString = videoItem.snippet.publishedAt
        let formattedDate = convertISO8601ToDateFormattedString(iso8601DateString: iso8601DateString, outputFormat: "MMM dd, yyyy HH:mm:ss")
        cell.dateLabel.text = formattedDate
        
        if let thumbnailUrl = URL(string: videoItem.snippet.thumbnails.medium.url) {
            URLSession.shared.dataTask(with: thumbnailUrl) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        if let currentIndexPath = tableView.indexPath(for: cell), currentIndexPath == indexPath {
                            cell.thumbnailImageView.image = image
                        }
                    }
                }
            }.resume()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let videoItem = videoItems[indexPath.row]

        if let videoId = videoItem.id.videoId {
            if let url = URL(string: "https://www.youtube.com/watch?v=\(videoId)") {
                let vc = SFSafariViewController(url: url)
                present(vc, animated: true)
            } else {
                print("Invalid URL for videoId: \(videoId)")
            }
        } else {
            print("Missing videoId")
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}


