import UIKit

class StartUpVC: UIViewController {

    @IBOutlet var signInButton: UIButton!
    @IBOutlet var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fontAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Arvo", size: 26) ?? UIFont.systemFont(ofSize: 17),
        ]
        let attributedTitleSignUp = NSAttributedString(string: "Sign Up", attributes: fontAttributes)
        let attributedTitleSignIn = NSAttributedString(string: "Sign In", attributes: fontAttributes)
        signInButton.setAttributedTitle(attributedTitleSignIn, for: .normal)
        signUpButton.setAttributedTitle(attributedTitleSignUp, for: .normal)
    }
}

