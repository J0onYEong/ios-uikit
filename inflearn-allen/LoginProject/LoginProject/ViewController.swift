//
//  ViewController.swift
//  LoginProject
//
//  Created by 최준영 on 2023/05/03.
//

import UIKit

final class ViewController: UIViewController {
    // MARK: - 이메일 입력
    lazy var emailTextFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.08648116142, green: 0.08648116142, blue: 0.08648116142, alpha: 1)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.addSubview(emailInfoLabel)
        view.addSubview(emailTextField)
        return view
    }()
    
    private let emailInfoLabel: UILabel = {
        let label = UILabel();
        label.text = "이메일주소 또는 전화번호"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        return label;
    }()
    
    private lazy var emailTextField: UITextField = {
        let tf = UITextField()
        tf.frame.size.height = 48
        tf.backgroundColor = .clear
        tf.textColor = .white
        tf.tintColor = .white
        tf.autocapitalizationType = .none
        tf.spellCheckingType = .no
        tf.keyboardType = .emailAddress
        tf.delegate = self
        tf.addTarget(self, action: #selector(textFieldEditting(_ :)), for: .editingChanged)
        return tf;
    }()
    
    
    // MARK: - 비밀번호 입력
    private lazy var passwordTextFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.08648116142, green: 0.08648116142, blue: 0.08648116142, alpha: 1)
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.addSubview(passwordTextField)
        view.addSubview(passwordInfoLabel)
        view.addSubview(passwordSecureButton)
        return view
    }()
    
    private lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .clear
        tf.frame.size.height = 48
        tf.backgroundColor = .clear
        tf.textColor = .white
        tf.tintColor = .white
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.isSecureTextEntry = true
        tf.clearsOnBeginEditing = false
        tf.delegate = self
        tf.addTarget(self, action: #selector(textFieldEditting(_ :)), for: .editingChanged)
        return tf
    }()
    
    private let passwordInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        return label
    }()
    
    private lazy var passwordSecureButton: UIButton = {
        let bt = UIButton(type: .custom)
        bt.setTitle("표시", for: .normal)
        bt.addTarget(self, action: #selector(passwordSecureModeSetting), for: .touchUpInside)
        return bt
    }()
    
    
    // MARK: - 로그인 버튼
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        button.setTitle("로그인", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.isEnabled = false
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - 비밀번호 재설정
    private lazy var passwordResetButton: UIButton = {
        let bt = UIButton()
        bt.backgroundColor = .clear
        bt.setTitle("비밀번호 재설정", for: .normal)
        bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        bt.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        return bt
    }()
    
    
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [emailTextFieldView, passwordTextFieldView, loginButton])
        stack.spacing = 18
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        return stack
    }()
    
    private let textViewHeight: CGFloat = 48;
    
    // NSLayoutConstraint는 클래스로 변경시 해당 인스턴스를 적용한 View의 오토레이아웃이 변경된다.
    private lazy var emailInfoLabelCenterYConstraint: NSLayoutConstraint = emailInfoLabel.centerYAnchor.constraint(equalTo: emailTextFieldView.centerYAnchor)
    
    private lazy var passwordInfoLabelCenterYConstraint: NSLayoutConstraint = passwordInfoLabel.centerYAnchor.constraint(equalTo: passwordTextFieldView.centerYAnchor)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setUpAutoLayout()
    }
    
    // viewController가 가지는 view에 터치가 발생하면 호출
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // view의 subview들의 firstResponder상태를 해제한다.
        self.view.endEditing(true)
    }
    
    func setUpAutoLayout() {
        // 최상단 view의 anchor를 사용하기위해 subView로 등록한다.
        view.addSubview(stackView)
        view.addSubview(passwordResetButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: textViewHeight*3 + 36),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        // emailTextFieldView
        emailTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        emailInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailTextFieldView.heightAnchor.constraint(equalToConstant: textViewHeight),
            // label
            emailInfoLabel.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8),
            emailInfoLabel.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: -8),
            emailInfoLabelCenterYConstraint,
            //textField
            emailTextField.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8),
            emailTextField.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: -8),
            emailTextField.topAnchor.constraint(equalTo: emailTextFieldView.topAnchor, constant: 15),
            emailTextField.bottomAnchor.constraint(equalTo: emailTextFieldView.bottomAnchor, constant: -2),
        ])
        
        // password
        passwordTextFieldView.translatesAutoresizingMaskIntoConstraints = false;
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false;
        passwordInfoLabel.translatesAutoresizingMaskIntoConstraints = false;
        passwordSecureButton.translatesAutoresizingMaskIntoConstraints = false;
        NSLayoutConstraint.activate([
            passwordTextFieldView.heightAnchor.constraint(equalToConstant: textViewHeight),
            // textField
            passwordTextField.topAnchor.constraint(equalTo: passwordTextFieldView.topAnchor, constant: 15),
            passwordTextField.bottomAnchor.constraint(equalTo: passwordTextFieldView.bottomAnchor, constant: -2),
            passwordTextField.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 8),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: -8),
            //label
            passwordInfoLabel.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 8),
            passwordInfoLabel.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: -8),
            passwordInfoLabelCenterYConstraint,
            // button
            passwordSecureButton.topAnchor.constraint(equalTo: passwordTextFieldView.topAnchor, constant: 15),
            passwordSecureButton.bottomAnchor.constraint(equalTo: passwordTextFieldView.bottomAnchor, constant: -15),
            passwordSecureButton.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: -8),
        ])
        
        // login button
        NSLayoutConstraint.activate([
            loginButton.heightAnchor.constraint(equalToConstant: textViewHeight),
        ])
        
        // password reset button
        passwordResetButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordResetButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 15),
            passwordResetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            passwordResetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            passwordResetButton.heightAnchor.constraint(equalToConstant: textViewHeight),
        ])
    }
    
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
    
    @objc
    func passwordSecureModeSetting() {
        self.passwordTextField.isSecureTextEntry.toggle()
    }
    
    @objc func textFieldEditting(_ textField: UITextField) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            loginButton.backgroundColor = .clear
            loginButton.isEnabled = false
            return
        }
        loginButton.backgroundColor = .red
        loginButton.isEnabled = true
    }
    
    @objc func loginButtonTapped() {
        print("로그인")
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.emailTextField {
            emailTextFieldView.backgroundColor = #colorLiteral(red: 0.175519526, green: 0.175519526, blue: 0.175519526, alpha: 1)
            emailInfoLabel.font = UIFont.systemFont(ofSize: 11)
            emailInfoLabelCenterYConstraint.constant = -13
        }
        else if textField == self.passwordTextField {
            passwordTextFieldView.backgroundColor = #colorLiteral(red: 0.175519526, green: 0.175519526, blue: 0.175519526, alpha: 1)
            passwordInfoLabel.font = UIFont.systemFont(ofSize: 11)
            passwordInfoLabelCenterYConstraint.constant = -13
        }
        
        // 오토레이아웃을 변경을 런루프가 인지하여 애니메이션을 적용하는 코드
        UIView.animate(withDuration: 0.2) {
            // stackView하위의 오토레이아웃 변화를 감지
            self.stackView.layoutIfNeeded()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.emailTextField {
            emailTextFieldView.backgroundColor = #colorLiteral(red: 0.08648116142, green: 0.08648116142, blue: 0.08648116142, alpha: 1)
            if textField.text == "" {
                emailInfoLabel.font = UIFont.systemFont(ofSize: 18)
                emailInfoLabelCenterYConstraint.constant = 0
            }
        }
        else if textField == self.passwordTextField {
            passwordTextFieldView.backgroundColor = #colorLiteral(red: 0.08648116142, green: 0.08648116142, blue: 0.08648116142, alpha: 1)
            if textField.text == "" {
                passwordInfoLabel.font = UIFont.systemFont(ofSize: 18)
                passwordInfoLabelCenterYConstraint.constant = 0
            }
        }
        UIView.animate(withDuration: 0.2) {
            self.stackView.layoutIfNeeded()
        }
    }
}

