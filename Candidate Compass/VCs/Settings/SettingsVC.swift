import UIKit
import Firebase

protocol SectionType: CustomStringConvertible {
    var containsSwitch: Bool { get }
}

enum SettingsSection: Int, CaseIterable, CustomStringConvertible {
    case account
    case contact
    
    var description: String {
        switch self {
            case .account: return "Account"
            case .contact: return "Contact"
        }
    }
}

enum AccountOptions: Int, CaseIterable, SectionType {
    case resetPassword
    case logOut
    case deleteAccount
    
    var containsSwitch: Bool { return false }
    
    var description: String {
        switch self {
            case .resetPassword: return "Reset Password"
            case .logOut: return "Log Out"
            case .deleteAccount: return "Delete Account"
        }
    }
}

enum ContactOptions: Int, CaseIterable, SectionType {
    case contactUs
    
    var containsSwitch: Bool { return false }
    
    var description: String {
        switch self {
            case .contactUs: return "Contact Us"
        }
    }
}

private let reuseIdentifier = "SettingsCell"

class SettingsVC: UIViewController {
    
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    func themeUpdated(_ isDarkModeEnabled: Bool) {
        if isDarkModeEnabled {
            tableView.backgroundColor = .darkGray
        } else {
            tableView.backgroundColor = .white
        }
    }
    
    func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        
        tableView.register(SettingsCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
        tableView.frame = view.frame

        tableView.tableFooterView = UIView()
    }
}

extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          guard let section = SettingsSection(rawValue: section) else { return 0 }
          
          switch section {
          case .account: return AccountOptions.allCases.count
          case .contact: return ContactOptions.allCases.count
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .systemBlue
        
        let title = UILabel()
        title.textColor = .systemBackground
        title.font = UIFont(name: "Arvo", size: 18)
        title.text = SettingsSection(rawValue: section)?.description
        view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        title.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SettingsCell
        guard let sectionType = SettingsSection(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch sectionType {
        case .account:
            let account = AccountOptions(rawValue: indexPath.row)
            cell.sectionType = account
        case .contact:
            let contact = ContactOptions(rawValue: indexPath.row)
            cell.sectionType = contact
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let sectionType = SettingsSection(rawValue: indexPath.section) else { return }
        
        switch sectionType {
        case .account:
            if let option = AccountOptions(rawValue: indexPath.row) {
                handleAccountOption(option)
            }
        case .contact:
            if let option = ContactOptions(rawValue: indexPath.row) {
                print(option.description)
            }
        }
    }

    func handleAccountOption(_ option: AccountOptions) {
        switch option {
        case .resetPassword:
            self.performSegue(withIdentifier: "goToReset", sender: self)
        case .logOut:
            handleLogOut()
        case .deleteAccount:
            handleDeleteAccount()
        }
    }

    func handleLogOut() {
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "goToStart", sender: self)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }

    func handleDeleteAccount() {
        guard let currentUser = Auth.auth().currentUser else { return }

        currentUser.delete { error in
            if let error = error {
                print("Error deleting account: \(error)")
            } else {
                print("Account deleted successfully")
            }
        }
        self.performSegue(withIdentifier: "goToStart", sender: self)
    }
}
