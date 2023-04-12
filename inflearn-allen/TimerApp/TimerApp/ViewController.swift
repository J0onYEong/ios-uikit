//
//  ViewController.swift
//  TimerApp
//
//  Created by 최준영 on 2023/04/10.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    
    weak var timer: Timer?
    var number: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func configureUI() {
        mainLabel.text = "초를 선택하세요"
        slider.value = 0.5
        number = 30
    }

    @IBAction func sliderChanged(_ sender: UISlider) {
        let sec = Int(sender.value * 60)
        mainLabel.text = "\(sec)초"
        number = sec
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        // 이미실행중인 타이머가 있다면 종료
        timer?.invalidate()
        // 새로운 타이머를 런루프에 등록후 프로퍼티에 weak참조
//        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [unowned self] t in
//            if number > 0 {
//                number -= 1
//                mainLabel.text = "\(number)초"
//                slider.setValue(Float(number) / 60.0, animated: true)
//            } else {
//                number = 0
//                mainLabel.text = "종료"
//                AudioServicesPlayAlertSound(SystemSoundID(1322))
//
//                // timer를 종료
//                t.invalidate()
//            }
//        })
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(calledByTimer), userInfo: nil, repeats: true)
    }
    
    @objc func calledByTimer() {
        if number > 0 {
            number -= 1
            mainLabel.text = "\(number)초"
            slider.setValue(Float(number) / 60.0, animated: true)
        } else {
            number = 0
            mainLabel.text = "종료"
            AudioServicesPlayAlertSound(SystemSoundID(1322))
            timer?.invalidate()
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        timer?.invalidate()
        slider.setValue(0.5, animated: true)
        number = 30
        mainLabel.text = "초를 선택하세요"
    }
    
}

