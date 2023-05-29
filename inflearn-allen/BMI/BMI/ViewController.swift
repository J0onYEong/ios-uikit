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
    
    private var bmi: Double?
    
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
    
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        if let h = heightTextField.text, let w = weightTextField.text {
            bmi = calculateBMI(height: h, weight: w)
        }
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
            guard let b = self.bmi else { return }
            secondVC.bmi = b
            secondVC.bmiColor = getBackgroundColor()
            secondVC.adviceString = getBMIAdviceString()
            
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


// MARK: - 계산 매서드
extension ViewController {
    //BMI계산
    func calculateBMI(height: String, weight: String) -> Double {
        guard let h = Double(height), let w = Double(weight) else { return 0.0 }
        var bmi = w / (h * h) * 10000
        //소수점 첫째자리이하는 버림
        bmi = round(bmi * 10) / 10
        return bmi
    }
    
    //색깔 얻는 메서드
    func getBackgroundColor() -> UIColor {
        guard let bmi = bmi else { return UIColor.black }
        switch bmi {
        case ..<18.6:
            return UIColor(displayP3Red: 22/255, green: 231/255, blue: 207/255, alpha: 1)
        case 18.6..<23.0:
            return UIColor(displayP3Red: 212/255, green: 251/255, blue: 121/255, alpha: 1)
        case 23.0..<25.0:
            return UIColor(displayP3Red: 218/255, green: 127/255, blue: 163/255, alpha: 1)
        case 25.0..<30.0:
            return UIColor(displayP3Red: 255/255, green: 150/255, blue: 141/255, alpha: 1)
        case 30.0...:
            return UIColor(displayP3Red: 255/255, green: 100/255, blue: 78/255, alpha: 1)
        default:
            return UIColor.black
        }
    }
    
    //문자열 얻는 메서드
    func getBMIAdviceString() -> String {
        guard let bmi = bmi else { return "" }
        switch bmi {
        case ..<18.6:
            return "저체중"
        case 18.6..<23.0:
            return "표준"
        case 23.0..<25.0:
            return "과체중"
        case 25.0..<30.0:
            return "중도비만"
        case 30.0...:
            return "고도비만"
        default:
            return ""
        }
    }
}

