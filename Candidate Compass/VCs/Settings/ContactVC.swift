//
//  ContactVC.swift
//  Candidate Compass
//
//  Created by Rohan Potta on 10/22/23.
//

import UIKit

class ContactVC: UIViewController {

    @IBOutlet var text: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        text.font = UIFont(name: "Arvo", size: 36)
    }

}
