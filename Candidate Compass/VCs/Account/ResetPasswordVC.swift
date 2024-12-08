import UIKit
import Firebase

class ResetPasswordVC: UIViewController {

    @IBOutlet var resetPasswordButton: UIButton!
    @IBOutlet var returnLabel: UILabel!
    @IBOutlet var emailTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        returnLabel.font = UIFont(name: "Arvo", size: 18)
        let fontAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Arvo", size: 18) ?? UIFont.systemFont(ofSize: 17),
        ]
        let attributedTitleSignUp = NSAttributedString(string: "Send Reset Confirmation", attributes: fontAttributes)
        resetPasswordButton.setAttributedTitle(attributedTitleSignUp, for: .normal)
    }
    
    @IBAction func resetClicked(_ sender: Any) {
        guard let email = emailTF.text else {return}
        
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("Password reset failed: \(error.localizedDescription)")
            } else {
                print("Password reset email sent successfully!")
            }
        }
    }
}
