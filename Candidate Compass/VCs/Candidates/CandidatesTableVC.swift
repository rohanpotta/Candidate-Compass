import UIKit
import CoreData

class CandidatesTableVC: UIViewController, UISearchBarDelegate {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    var partySections: [String] = []
    var originalData: [Candidate] = []
    var filteredData: [Candidate] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        originalData = createCandidates()
        filteredData = originalData
        for candidate in originalData {
            if !partySections.contains(candidate.party) {
                partySections.append(candidate.party)
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredData = originalData
        } else {
            filteredData = originalData.filter { item in
            return item.name.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
}

extension CandidatesTableVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return partySections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let party = partySections[section]
        return filteredData.filter { $0.party == party }.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return partySections[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.frame = CGRect(x: 20, y: 8, width: 320, height: 20)
            header.textLabel!.font = UIFont(name: "Arvo", size: 16)
            header.textLabel!.textColor = UIColor.label
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CandidatesCell", for: indexPath) as! CandidatesTableViewCell
        let party = partySections[indexPath.section]
        let candidatesForParty = filteredData.filter { $0.party == party }
        let candidate = candidatesForParty[indexPath.row]
        cell.candidateNameLabel.text = candidate.name
        cell.candidateTitleLabel.text = candidate.title
        cell.profileImage.image = candidate.profilePic
        
        let imageData = candidate.profilePic.pngData()
        let name = candidate.name
        
        if let imageData = imageData,
           let userID = CDHelper.fetchUID() {
            
            let context = CDHelper.shared.persistentContainer.viewContext
            
            let fetchRequest: NSFetchRequest<FollowedCandidate> = FollowedCandidate.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "nameCD == %@ AND profileImageCD == %@ AND userID == %@", name, imageData as NSData, userID)
            
            do {
                let followedCandidates = try context.fetch(fetchRequest)
                let isFollowed = !followedCandidates.isEmpty
                let starImageName = isFollowed ? "star.fill" : "star"
                cell.followButton.setImage(UIImage(systemName: starImageName), for: .normal)
            } catch {
                print("Error fetching followed candidates: \(error)")
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let party = partySections[indexPath.section]
        let candidates = originalData.filter { $0.party == party }
        let selectedCandidate = candidates[indexPath.row]
        performSegue(withIdentifier: "GoToCandidateDetails", sender: selectedCandidate)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToCandidateDetails",
            let destinationVC = segue.destination as? CandidateDetailsVC,
            let selectedCandidate = sender as? Candidate {
            destinationVC.candidate = selectedCandidate
        }
    }
}
