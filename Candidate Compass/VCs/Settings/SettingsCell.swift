import UIKit

class SettingsCell: UITableViewCell {
    
    var sectionType: SectionType? {
        didSet {
            guard let sectionType = sectionType else { return }
            textLabel?.text = sectionType.description
            textLabel?.font = UIFont(name: "Arvo", size: 16)
            darkModeToggleSwitch.isHidden = !sectionType.containsSwitch
        }
    }
    
    lazy var darkModeToggleSwitch: UISwitch = {
       let darkModeToggleSwitch = UISwitch()
       darkModeToggleSwitch.onTintColor = .systemBlue
       darkModeToggleSwitch.translatesAutoresizingMaskIntoConstraints = false
       darkModeToggleSwitch.addTarget(self, action: #selector(toggleDarkMode), for: .valueChanged)
       darkModeToggleSwitch.setOn(true, animated: false)
       return darkModeToggleSwitch
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(darkModeToggleSwitch)
        darkModeToggleSwitch.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        darkModeToggleSwitch.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func toggleDarkMode(_ sender: UISwitch) {
        if sender.isOn {
            overrideUserInterfaceStyle = .dark
        }
        else {
            overrideUserInterfaceStyle = .light
        }
    }
}

