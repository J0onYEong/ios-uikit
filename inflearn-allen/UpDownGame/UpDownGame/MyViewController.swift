//
//  ViewController.swift
//  UpDownGame
//
//  Created by 최준영 on 2023/04/09.
//

import UIKit

class MyViewController: UIViewController {

    // Label
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var userChoiceLabel: UILabel!
    
    weak var previousButton: UIButton?
    
    let normalColor = UIColor.systemGreen
    let selectedColor = UIColor.red
    
    var comChoice = Int.random(in: 1...10)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        mainLabel.text = "수를 선택하세요!"
        userChoiceLabel.text = ""
    }
    

    @IBAction func numberButtonPressed(_ sender: UIButton) {
        // 버튼 색상변경
        sender.backgroundColor = selectedColor
        if let pButton = previousButton {
            pButton.backgroundColor = normalColor
        }
        
        // 선택한 버튼으로부터 숫자추출
        guard let numString = sender.currentTitle else {return}
        
        // label에 표시
        userChoiceLabel.text = numString
        
        // 이전 버튼으로 추가
        previousButton = sender
    }
    
    @IBAction func selectButtonPressed(_ sender: UIButton) {
        guard let numString = userChoiceLabel.text else {return}
        guard let number = Int(numString) else {return}
        
        if comChoice == number {
            mainLabel.text = "빙고!"
        } else if comChoice > number {
            mainLabel.text = "Up"
        } else {
            mainLabel.text = "Down"
        }
        
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        mainLabel.text = "수를 선택하세요!"
        userChoiceLabel.text = ""
        
        previousButton?.backgroundColor = normalColor
        previousButton = nil
    }
    
    
}

