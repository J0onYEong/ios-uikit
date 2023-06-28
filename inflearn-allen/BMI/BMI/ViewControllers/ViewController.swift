//
//  ViewController.swift
//  BMI
//
//  Created by 최준영 on 2023/05/30.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    
    
    var bmiManager = BMICalculatorManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureUI()
    }
    
    func configureUI() {
        
        //Label
        mainLabel.text = "키와 몸무개를 입력하세요"
        
        //TextFields
        heightTextField.delegate = self
        weightTextField.delegate = self
        heightTextField.placeholder = "cm단위로 입력하세요"
        weightTextField.placeholder = "kg단위로 입력하세요"
        
        //Button
        nextButton.clipsToBounds = true
        nextButton.layer.cornerRadius = 8
        nextButton.setTitle("BMI계산", for: .normal)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        heightTextField.resignFirstResponder()
        weightTextField.resignFirstResponder()
    }
    
    
    // MARK: - Routing
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if heightTextField.text == "" || weightTextField.text == "" {
            mainLabel.text = "키와 몸무개를 모두 입력해 주세요"
            mainLabel.textColor = .red
            return false
        }
        mainLabel.text = "키와 몸무개를 입력하세요"
        mainLabel.textColor = .black
        return true
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveToBMI" {
            let secondVC = segue.destination as! SecondViewController
            //계산된 결과값 전달
            if let h = heightTextField.text, let w = weightTextField.text {
                secondVC.bmi = bmiManager.getBMIResult(height: h, weight: w)
            }
            
            //데이터전달이 완료됬다면 초기화
            heightTextField.text = ""
            weightTextField.text = ""
        }
    }
    
    
}

extension ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //숫자만 입력되는 로직
        if Int(string) != nil || string == "" {
            return true
        }
        
        return false
     }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if heightTextField.text != "", weightTextField.text != "" {
            weightTextField.resignFirstResponder()
            return true
        } else if heightTextField.text != "" {
            weightTextField.becomeFirstResponder()
            return true
        }
        return false
    }
}

