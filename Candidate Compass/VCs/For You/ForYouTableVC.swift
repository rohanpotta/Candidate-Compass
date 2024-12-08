import UIKit

class ForYouTableVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var followedCandidates: [FollowedCandidate] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        followedCandidates = CDHelper.shared.retrieveFollowedCandidates()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: Notification.Name("FollowButtonTapped"), object: nil)
    }
    
    @objc func reloadTableView() {
        followedCandidates = CDHelper.shared.retrieveFollowedCandidates()
        tableView.reloadData()
    }
    
    func formatCandidateName(_ name: String) -> String {
        let encodedName = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        return encodedName
    }
}

extension ForYouTableVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followedCandidates.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForYouTableViewCellID", for: indexPath) as! ForYouTableViewCell
        let followedCandidate = followedCandidates[indexPath.row]

        cell.nameLabel.text = "Catch up on the latest news about \(followedCandidate.nameCD ?? "Unknown Candidate")"
        if let imageData = followedCandidate.profileImageCD, let image = UIImage(data: imageData) {
            cell.profileImageView.image = image
        }
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let followedCandidate = followedCandidates[indexPath.row]
        if let candidateName = followedCandidate.nameCD {
            performSegue(withIdentifier: "GoToYouTubeFeed", sender: candidateName)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToYouTubeFeed",
           let destinationVC = segue.destination as? ForYouVideosVC,
           let candidateName = sender as? String {
           let formattedCandidateName = formatCandidateName(candidateName)
           destinationVC.keyword = candidateName
        }
    }
}
