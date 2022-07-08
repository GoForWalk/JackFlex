//
//  ViewController.swift
//  JackFilx
//
//  Created by sae hun chung on 2022/07/06.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var couponTextField: UITextField!
    
    @IBOutlet var textFields: [UITextField]!
    
    @IBOutlet weak var joinButton: UIButton!
    
    @IBOutlet weak var additonalInfoSwitch: UISwitch!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFields.forEach { $0.delegate = self }
        
        setUI()
    }

    func setUI() {
        setTextFieldUI(textField: idTextField, placeholder: "이메일 주소 또는 전화번호")
        setTextFieldUI(textField: pwTextField, placeholder: "비밀번호", isSecure: true)
        setTextFieldUI(textField: nicknameTextField, placeholder: "닉네임")
        setTextFieldUI(textField: addressTextField, placeholder: "위치")
        setTextFieldUI(textField: couponTextField, placeholder: "추천 코드 입력", keyboardType: .numberPad)
        
        setButtonUI()
        setSwitchUI()
        errorLabel.isHidden = true
        
        
    }
    
    func setTextFieldUI(textField: UITextField, placeholder: String, keyboardType: UIKeyboardType = .default, isSecure: Bool = false) {
        
        textField.layer.cornerRadius = 8
        textField.backgroundColor = .darkGray
        textField.textColor = .white
        textField.textAlignment = .center
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        
        textField.keyboardType = keyboardType
        textField.isSecureTextEntry = isSecure
        textField.clearButtonMode = .always

    }
    
    
    func setButtonUI() {
        joinButton.setTitle("회원가입", for: .normal)
        joinButton.setTitleColor(.black, for: .normal)
        
        joinButton.layer.cornerRadius = 8
        joinButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
    }
    
    func setSwitchUI() {
        additonalInfoSwitch.setOn(true, animated: true)
        additonalInfoSwitch.onTintColor = .red
        additonalInfoSwitch.thumbTintColor = .white
        additonalInfoSwitch.backgroundColor = .green
        additonalInfoSwitch.layer.cornerRadius = 16
        
        additonalInfoSwitch.layer.allowsGroupOpacity = true
    }
    
    func errorMsg() {
        errorLabel.textColor = .red
        errorLabel.font = .boldSystemFont(ofSize: 20)
        errorLabel.text = "정보를 다시 확인해 주세요!!"
    }
    
    func okMsg() {
        errorLabel.textColor = .green
        errorLabel.font = .boldSystemFont(ofSize: 20)
        errorLabel.text = "🌱 가입되었습니다!"
    }
    
    @IBAction func joinButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
        
        if checkID() && checkPW() && checkCoupon() {
            okMsg()
            errorLabel.isHidden = false
        } else {
            errorMsg()
            errorLabel.isHidden = false
            
        }
    }
    
    @IBAction func tapGestureTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        errorLabel.isEnabled = true
    }
    
    @IBAction func additionalSwitchToggled(_ sender: UISwitch) {
        
        if sender.isOn == false {
            addressTextField.isHidden = true
            couponTextField.isHidden = true
        } else if sender.isOn == true {
            addressTextField.isHidden = false
            couponTextField.isHidden = false
        }
        
    }
    
    func checkPW() -> Bool {
        
        guard let pw = pwTextField.text else { return false }
        
        if pw.count < 5 { return false }
               
        return true
    }
    
    func checkID() -> Bool {
        
        guard let _ = idTextField.text else { return false }
        
        return true
    }
    
    func checkCoupon() -> Bool {
        
        guard let coupon = couponTextField.text else { return true }
        
        if Int(coupon + "1") == nil { return false }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return textField.resignFirstResponder()
    }
    
}


