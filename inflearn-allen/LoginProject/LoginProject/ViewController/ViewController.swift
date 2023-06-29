//
//  ViewController.swift
//  LoginProject
//
//  Created by 최준영 on 2023/05/03.
//

import UIKit

final class ViewController: UIViewController {
    
    let loginView = LoginView()
    
    //viewDidLoad보다 먼저 호출되는 매서드
    override func loadView() {
        view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        allocateActionMethod()
    }
    
    // viewController가 가지는 view에 터치가 발생하면 호출
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // view의 subview들의 firstResponder상태를 해제한다.
        self.view.endEditing(true)
    }
    
    
    func allocateActionMethod() {
        
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginView.passwordResetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
    }

}



// MARK: - Target Method
extension ViewController {
    
    @objc
    func resetButtonTapped() {
        let alertController = UIAlertController(title: "비밀번호 초기화", message: "초기화 하시겠습니까?", preferredStyle: .alert)
        
        let confirm = UIAlertAction(title: "확인", style: .default) { _ in
            print("확인")
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel) { _ in
            print("취소")
        }
        
        alertController.addAction(confirm)
        alertController.addAction(cancel)
        
        present(alertController, animated: true)
    }
    
    @objc func loginButtonTapped() {
        print("로그인")
    }
}

