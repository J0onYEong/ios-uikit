//
//  SecondViewController.swift
//  BMI
//
//  Created by 최준영 on 2023/05/30.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    @IBOutlet weak var dismissButton: UIButton!
    
    
    var bmi: Double?
    var adviceString: String?
    var bmiColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    func configureUI() {
        //Button
        dismissButton.clipsToBounds = true
        dismissButton.layer.cornerRadius = 8
        dismissButton.setTitle("돌아가기", for: .normal)
        
        //Label
        label1.text = "BMI결과값"
        
        label2.backgroundColor = bmiColor
        label2.clipsToBounds = true
        label2.layer.cornerRadius = 8
        label2.text = String(bmi ?? 0.0)
        
        label3.text = adviceString ?? ""
        
    }

    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}
