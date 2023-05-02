//
//  ViewController.swift
//  LoginProject
//
//  Created by 최준영 on 2023/05/03.
//

import UIKit

class ViewController: UIViewController {
    
    // 지연호출로 클로저내부에서 addSubView를 해줄수 있지만 오토레이아웃과 함께 선언하는게 가독성이 좋다고 생각된다.
    var emailTextFeildView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
    }
    
    // autolayout은 밖으로 분리하는 것이 깔끔한 것 같다.
    func makeUI() {
        // 최상단 view의 anchor를 사용하기위해 subView로 등록한다.
        view.addSubview(emailTextFeildView)
        
        // 자동으로 오토레이아웃을 설정하는 기능을 끈다
        emailTextFeildView.translatesAutoresizingMaskIntoConstraints = false
        // 수동 설정
        emailTextFeildView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        // 좌표기준으로 동작함으로 trailing, bottom 레이아웃을 사용할 때는 음수값을 전달해야 한다.
        emailTextFeildView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        emailTextFeildView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        // 기준없이 설정하는 방법
        emailTextFeildView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }


}

