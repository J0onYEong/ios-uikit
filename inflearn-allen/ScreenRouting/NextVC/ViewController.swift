//
//  ViewController.swift
//  NextVC
//
//  Created by Allen H on 2021/12/05.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // 1) 코드로 화면 이동 (다음화면이 코드로 작성되어있을때만 가능한 방법)
    @IBAction func codeNextButtonTapped(_ sender: UIButton) {
        let firstVC = FirstViewController()
        firstVC.labelStr = "seding data"
        firstVC.modalPresentationStyle = .fullScreen
        
        present(firstVC, animated: true)
        
    }
    
    // 2) 코드로 스토리보드 객체를 생성해서, 화면 이동
    @IBAction func storyboardWithCodeButtonTapped(_ sender: UIButton) {
        if let secondVC = storyboard?.instantiateViewController(withIdentifier: "secondVC") as? SecondViewController {
            
            secondVC.labelStr = "데이터"
            
            present(secondVC, animated: true)
        }
    }
    
    
    
    // 3) 스토리보드에서의 화면 이동(간접 세그웨이)
    @IBAction func storyboardWithSegueButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "toThirdVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toThirdVC" {
            let vc = segue.destination as! ThirdViewController
            vc.labelStr = "전달하고싶은 데이터"
        }
        
        if segue.identifier == "toFourthVC" {
            let vc = segue.destination as! FourthViewController
            vc.labelStr = "전달하고 싶어용"
        }
    }
    
    // 4) 직접 세그웨이
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "toFourthVC" {
            return true
        }
        return false
    }

}

