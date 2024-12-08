import UIKit
import SafariServices

class CandidateDetailsVC: UIViewController {
    
    @IBOutlet var candidateProfileImage: UIImageView!
    @IBOutlet var candidateNameLabel: UILabel!
    @IBOutlet var openWebsiteButton: UIButton!
    @IBOutlet var bioLabel: UILabel!
    @IBOutlet var bio: UILabel!
    @IBOutlet var stances: UILabel!
    @IBOutlet var stancesLabel: UILabel!
    @IBOutlet var campaign: UILabel!
    @IBOutlet var campaignLabel: UILabel!
    
    var candidate: Candidate?

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeDetails()
    }
    
    @IBAction func openWebsiteClicked(_ sender: Any) {
        guard let candidate = candidate, let websiteURL = candidate.website else {
            print("Candidate information or website URL is missing.")
            return
        }
        let safariViewController = SFSafariViewController(url: websiteURL)
        present(safariViewController, animated: true, completion: nil)
    }
    
    private func initializeDetails() {
        candidateProfileImage.layer.cornerRadius = candidateProfileImage.frame.size.width / 2
        candidateProfileImage.clipsToBounds = true
        candidateNameLabel.font = UIFont(name: "Arvo", size: 24)
        candidateProfileImage.image = candidate?.profilePic
        candidateNameLabel.text = candidate?.name
        let fontAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Arvo", size: 17) ?? UIFont.systemFont(ofSize: 17),
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let attributedTitle = NSAttributedString(string: "Visit \(candidate?.name ?? "Candidate")'s Website", attributes: fontAttributes)
        openWebsiteButton.setAttributedTitle(attributedTitle, for: .normal)
        bioLabel.font = UIFont(name: "Arvo", size: 16)
        bioLabel.text = candidate?.bioLabel
        bio.font = UIFont(name: "Arvo", size: 20)
        bio.addUnderline()
        stances.font = UIFont(name: "Arvo", size: 20)
        stances.addUnderline()
        stancesLabel.text = candidate?.stancesLabel
        stancesLabel.font = UIFont(name: "Arvo", size: 16)
        campaign.font = UIFont(name: "Arvo", size: 20)
        campaign.addUnderline()
        campaignLabel.font = UIFont(name: "Arvo", size: 16)
        campaignLabel.text = candidate?.campaignLabel
    }
}
