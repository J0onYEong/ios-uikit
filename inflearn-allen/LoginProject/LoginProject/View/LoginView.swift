//
//  LoginView.swift
//  LoginProject
//
//  Created by 최준영 on 2023/06/29.
//

import UIKit


class LoginView: UIView {
    
    private let textViewHeight: CGFloat = 48;
    
    // NSLayoutConstraint는 클래스로 변경시 해당 인스턴스를 적용한 View의 오토레이아웃이 변경된다.
    private lazy var emailInfoLabelCenterYConstraint: NSLayoutConstraint = emailInfoLabel.centerYAnchor.constraint(equalTo: emailTextFieldView.centerYAnchor)
    
    private lazy var passwordInfoLabelCenterYConstraint: NSLayoutConstraint = passwordInfoLabel.centerYAnchor.constraint(equalTo: passwordTextFieldView.centerYAnchor)
    
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
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        button.setTitle("로그인", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.isEnabled = false
        return button
    }()
    
    // MARK: - 비밀번호 재설정
    lazy var passwordResetButton: UIButton = {
        let bt = UIButton()
        bt.backgroundColor = .clear
        bt.setTitle("비밀번호 재설정", for: .normal)
        bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
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
    
    
    //viewDidLoad와 비슷한 기능을 한다.
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
        addViews()
        setUpAutoLayout()
    }
    
    
    
    //UIView의 생성자를 재정의 할경우 아래 생성자를 반드시 재정의 해야한다.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



// MARK: - Target 매서드
extension LoginView {
    
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
    
    @objc
    func passwordSecureModeSetting() {
        self.passwordTextField.isSecureTextEntry.toggle()
    }
    
}



// MARK: - configuration
extension LoginView {
    func setUp() {
        backgroundColor = UIColor.black
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func addViews() {
        self.addSubview(stackView)
        self.addSubview(passwordResetButton)
    }
    
    
    func setUpAutoLayout() {
        // 최상단 view의 anchor를 사용하기위해 subView로 등록한다.
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: textViewHeight*3 + 36),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
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
            passwordResetButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            passwordResetButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            passwordResetButton.heightAnchor.constraint(equalToConstant: textViewHeight),
        ])
    }
}


// MARK: - UITextFieldDelegate
extension LoginView: UITextFieldDelegate {
    
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
