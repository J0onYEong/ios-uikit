//
//  SecondViewController.swift
//  NextVC
//
//  Created by Allen H on 2021/12/05.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var mainLabel: UILabel!
    
    var labelStr: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainLabel.text = labelStr ?? ""
    }
    
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}






