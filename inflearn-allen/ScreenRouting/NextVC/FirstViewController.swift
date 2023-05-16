//
//  FirstViewController.swift
//  NextVC
//
//  Created by 최준영 on 2023/05/17.
//

import UIKit

class FirstViewController: UIViewController {
    lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        label.text = labelStr ?? ""
        return label
    }()
    
    lazy var dismissBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("Back", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .blue
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    //라우팅시 전달받는 데이터
    var labelStr: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureUI()
    }
    
    
    func configureUI() {
        view.backgroundColor = .gray
        
        view.addSubview(mainLabel)
        view.addSubview(dismissBtn)
        
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        dismissBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            dismissBtn.widthAnchor.constraint(equalToConstant: 70),
            dismissBtn.heightAnchor.constraint(equalToConstant: 40),
            dismissBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            dismissBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc
    func backButtonTapped() {
        dismiss(animated: true)
    }

}
