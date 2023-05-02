//
//  ViewController.swift
//  TextFeildApp
//
//  Created by 최준영 on 2023/04/13.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        view.backgroundColor = .systemGray
        
        textField.placeholder = "이메일을 입력하세요"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        // 입력한 text를 제거할 수 있는 clear버튼 생성 여부
        textField.clearButtonMode = .always
        textField.returnKeyType = .done
        
        // TextFeild를 FirstReponder로지정하면 View집입시 먼저 Focus된다.
        textField.becomeFirstResponder()
        textField.delegate = self
    }   
    @IBAction func enterButtonPressed(_ sender: UIButton) {
        textField.resignFirstResponder()
    }
    
    
    // UITextFeildDelegate구현
    
    // 1. firstResponder로 지정되면 최초로 호출된다.
    // false를 반환할 경우 자동으로 firstResponder를 resign한다.
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print(#function)
        return true
    }
    // 2. textFieldShouldBeginEditing이 true를 반환할 경우 다음으로 호출된다.
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(#function)
    }
    
    
    // firstReponder에서 사임하면 호출된다.
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(#function)
    }
    
    // textField에 입력이 들어올 때마다 호출된다.
    // true를 반환하면 방금입력된 입력(문자, 문자열(paste))가 field에 기록되지 못한다.
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 10
        let nsString = NSString(string: textField.text ?? "")
        let newString = nsString.replacingCharacters(in: range, with: string)
        
        return newString.unicodeScalars.count <= maxLength
    }
    
    // 입력이 들어온 후 위 함수가 호출된 이후에 호출된다.
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print(#function)
    }
    
    // clear버튼을 누르면 호출된다.
    // true를 반환할 경우 clear를 허가한다.
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print(#function)
        return true
    }
    // 키보드의 리턴키를 누를 경우 호출된다.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(#function)
        return true
    }
    
    
    // textFeild가 firstReponder를 그만두라는 요청을 받았을 때 호출
    // false를 반환하면 firstResponder상태를 유지한다.
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print(#function)
        return true
    }
    // firstReponder를 resign한 직후 호출
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        print(#function)
    }
    
    // EditMenu가 보여지는 즉시 호출된다.
    func textField(_ textField: UITextField, willPresentEditMenuWith animator: UIEditMenuInteractionAnimating) {
        print(#function)
    }
    // EditMenu가 사라진 후에 호출된다.
    func textField(_ textField: UITextField, willDismissEditMenuWith animator: UIEditMenuInteractionAnimating) {
        print(#function)
    }
    
    func textField(_ textField: UITextField, editMenuForCharactersIn range: NSRange, suggestedActions: [UIMenuElement]) -> UIMenu? {
        return .none
    }

    // 스크린을 터치를 감지하는 매서드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        textField.resignFirstResponder()
    }
}

