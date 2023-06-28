//
//  BMICalculatorManager.swift
//  BMI
//
//  Created by 최준영 on 2023/06/28.
//

import Foundation
import UIKit

struct BMICalculatorManager {
    
    private var bmi: BMI?
    
    //BMI get
    mutating func getBMIResult(height: String, weight: String) -> BMI {
        
        calculateBMI(height: height, weight: weight)
        
        return bmi ?? BMI(value: 0.0, advice: "계산 오류", color: .white)
    }
    
    
    //BMI계산
    mutating private func calculateBMI(height: String, weight: String) {
        guard let h = Double(height), let w = Double(weight) else {
            return;
        }
        var bmiValue = w / (h * h) * 10000
        
        //소수점 첫째자리이하는 버림
        bmiValue = round(bmiValue * 10) / 10
        
        var bmiColor: UIColor
        
        switch bmiValue {
        case ..<18.6:
            bmiColor = UIColor(displayP3Red: 22/255, green: 231/255, blue: 207/255, alpha: 1)
            bmi = BMI(value: bmiValue, advice: "저체중", color: bmiColor)
        case 18.6..<23.0:
            bmiColor = UIColor(displayP3Red: 212/255, green: 251/255, blue: 121/255, alpha: 1)
            bmi = BMI(value: bmiValue, advice: "표준", color: bmiColor)
        case 23.0..<25.0:
            bmiColor = UIColor(displayP3Red: 218/255, green: 127/255, blue: 163/255, alpha: 1)
            bmi = BMI(value: bmiValue, advice: "과체중", color: bmiColor)
        case 25.0..<30.0:
            bmiColor = UIColor(displayP3Red: 255/255, green: 150/255, blue: 141/255, alpha: 1)
            bmi = BMI(value: bmiValue, advice: "중도비만", color: bmiColor)
        case 30.0...:
            bmiColor = UIColor(displayP3Red: 255/255, green: 100/255, blue: 78/255, alpha: 1)
            bmi = BMI(value: bmiValue, advice: "고도비만", color: bmiColor)
        default:
            bmiColor = UIColor.black
            bmi = BMI(value: bmiValue, advice: "", color: bmiColor)
        }
        
    }
    
}
