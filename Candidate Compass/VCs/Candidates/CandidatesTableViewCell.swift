import UIKit
import CoreData

class CandidatesTableViewCell: UITableViewCell {

    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var candidateNameLabel: UILabel!
    @IBOutlet var candidateTitleLabel: UILabel!
    @IBOutlet var followButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
        candidateNameLabel.font = UIFont(name: "Arvo", size: 17.0)
        candidateTitleLabel.font = UIFont(name: "Arvo", size: 12.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func followButtonTapped(_ sender: Any) {
        if let name = candidateNameLabel.text, let profileImage = profileImage.image {
            let context = CDHelper.shared.persistentContainer.viewContext

            let fetchRequest: NSFetchRequest<FollowedCandidate> = FollowedCandidate.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "nameCD == %@ AND profileImageCD == %@", name, profileImage.pngData()! as NSData)

            do {
                let followedCandidates = try context.fetch(fetchRequest)
                if let followedCandidate = followedCandidates.first {
                    CDHelper.shared.deleteFollowedCandidate(candidate: followedCandidate)
                    followButton.setImage(UIImage(systemName: "star"), for: .normal)
                } else {
                    CDHelper.shared.addFollowedCandidate(candidatename: name, profileimage: profileImage)
                    followButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
                }
                // Reload the table view after modifying data
                NotificationCenter.default.post(name: Notification.Name("FollowButtonTapped"), object: nil)
            } catch {
                print("Error checking or modifying followed candidates: \(error)")
            }
        }
    }
}
