//
//  LoginViewController.swift
//  LuxPm-Demo
//
//  Created by Sandeep Ahuja on 03/08/21.
//

import UIKit

class LoginViewController: UIViewController {
  // MARK: - Properties
  lazy var logoImage = UIImageView()
  lazy var logoLabel = UILabel()
  lazy var emailLabel = UILabel()
  lazy var emailPlaceHolderImage = UIImageView()
  lazy var emailTextField = UITextField()
  lazy var emailBottomView = UIView()
  lazy var passwordLabel = UILabel()
  lazy var passwordPlaceHolderImage = UIImageView()
  lazy var passwordTextField = UITextField()
  lazy var passwordBottomView = UIView()
  lazy var forgotPasswordButton = UIButton()
  lazy var loginButton = UIButton()
  lazy var signUpButton = UIButton()
  
  lazy var inputToolbar: UIToolbar = {
    var toolbar = UIToolbar()
    toolbar.barStyle = .default
    toolbar.isTranslucent = true
    toolbar.sizeToFit()
    
    var doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
    toolbar.setItems([doneButton], animated: false)
    toolbar.isUserInteractionEnabled = true
    
    return toolbar
  }()
  
  private let viewModel: LoginViewModel
  
  // MARK: - LifeCycle
  
  init(viewModel: LoginViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.navigationBar.isHidden = true
    configureViews()
    configureConstraints()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    configureBindings()
  }
  
  // MARK: - Helpers
  func configureBindings() {
    viewModel.showAlertClosure = { [weak self] title, message, completionHandler in
      DispatchQueue.main.async {
        self?.showAlertOK(title: title, message: message, completionHandler: completionHandler)
      }
    }
  }
  
  // MARK: - Actions
  @objc func forgotButtonTapped() {
    let viewController = ForgotPasswordViewController(viewModel: ForgotPasswordViewModel())
    navigationController?.pushViewController(viewController, animated: true)
  }
  
  @objc func loginButtonTapped() {
    let email = viewModel.getSetEmail
    let password = viewModel.getSetPassword
    viewModel.loginUser(email: email, password: password) { status in
      if status {
        let viewController = DashBoardViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
      }
    }
  }
  
  @objc func signUpButtonTapped() {
    print("Signup Pressed")
  }
  
  @objc func doneButtonTapped() {
    view.endEditing(true)
  }
  
  @objc func toggleButtonTapped(_ sender: UIButton) {
    if sender.isSelected {
      passwordTextField.isSecureTextEntry = true
      sender.isSelected = false
    } else {
      passwordTextField.isSecureTextEntry = false
      sender.isSelected = true
    }
  }
}

extension LoginViewController: UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField) {
    guard let textFieldText = textField.text else { return }
    if textField.tag == 0 {
      viewModel.validateEmail(email: textFieldText)
    } else {
      viewModel.validatePassword(password: textFieldText)
    }
  }
}

extension LoginViewController {
  func configureViews() {
    view.backgroundColor = .white
    
    logoImage = {
      let image = UIImage(named: "gradation")
      let imageView = UIImageView(image: image)
      imageView.contentMode = .scaleAspectFit
      imageView.translatesAutoresizingMaskIntoConstraints = false
      return imageView
    }()
    
    logoLabel = {
      let label = UILabel()
      label.text = "로그인"
      label.font = UIFont.systemFont(ofSize: 23)
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
    }()
    
    emailLabel = {
      let label = UILabel()
      label.text = "Email"
      label.font = UIFont.systemFont(ofSize: 12)
      label.textColor = #colorLiteral(red: 0.7176470588, green: 0.7176470588, blue: 0.7176470588, alpha: 1)
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
    }()
    
    emailPlaceHolderImage = {
      let image = UIImage(named: "email")
      let imageView = UIImageView(image: image)
      imageView.contentMode = .scaleAspectFit
      imageView.translatesAutoresizingMaskIntoConstraints = false
      return imageView
    }()
    
    emailTextField = {
      let textField = UITextField()
      textField.placeholder = "sabahat@gmail.com"
      textField.font = UIFont.systemFont(ofSize: 16)
      textField.borderStyle = .none
      textField.autocapitalizationType = .none
      textField.delegate = self
      textField.autocorrectionType = .no
      textField.keyboardType = .emailAddress
      textField.textContentType = .emailAddress
      textField.clearButtonMode = .whileEditing
      textField.inputAccessoryView = inputToolbar
      textField.tag = 0
      textField.translatesAutoresizingMaskIntoConstraints = false
      return textField
    }()
    
    emailBottomView = {
      let view = UIView()
      view.backgroundColor = #colorLiteral(red: 0.0862745098, green: 0.06666666667, blue: 0.05098039216, alpha: 1)
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
    }()
    
    passwordLabel = {
      let label = UILabel()
      label.text = "비밀번호"
      label.font = UIFont.systemFont(ofSize: 12)
      label.textColor = #colorLiteral(red: 0.7176470588, green: 0.7176470588, blue: 0.7176470588, alpha: 1)
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
    }()
    
    passwordPlaceHolderImage = {
      let image = UIImage(named: "lock")
      let imageView = UIImageView(image: image)
      imageView.contentMode = .scaleAspectFit
      imageView.translatesAutoresizingMaskIntoConstraints = false
      return imageView
    }()
    
    passwordTextField = {
      let textField = UITextField()
      textField.placeholder = "**********"
      textField.font = UIFont.systemFont(ofSize: 16)
      textField.borderStyle = .none
      textField.autocapitalizationType = .none
      textField.delegate = self
      textField.autocorrectionType = .no
      textField.textContentType = .password
      textField.inputAccessoryView = inputToolbar
      textField.isSecureTextEntry = true
      textField.tag = 1
      
      let button = UIButton(type: .custom)
      button.setImage(UIImage(named: "eye_open"), for: .normal)
      button.setImage(UIImage(named: "eye_close"), for: .selected)
      button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
      button.frame = CGRect(
        x: CGFloat(textField.frame.size.width - 25),
        y: CGFloat(5),
        width: CGFloat(10),
        height: CGFloat(10)
      )
      button.addTarget(self, action: #selector(toggleButtonTapped), for: .touchUpInside)
      
      textField.rightView = button
      textField.rightViewMode = .always
      textField.translatesAutoresizingMaskIntoConstraints = false
      return textField
    }()
    
    passwordBottomView = {
      let view = UIView()
      view.backgroundColor = #colorLiteral(red: 0.0862745098, green: 0.06666666667, blue: 0.05098039216, alpha: 1)
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
    }()
    
    forgotPasswordButton = {
      let button = UIButton()
      button.setTitle("비밀번호 찾기", for: .normal)
      button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
      button.setTitleColor(.black, for: .normal)
      button.addTarget(self, action: #selector(forgotButtonTapped), for: .touchUpInside)
      button.translatesAutoresizingMaskIntoConstraints = false
      return button
    }()
    
    loginButton = {
      let button = UIButton()
      button.setTitle("로그인", for: .normal)
      button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
      button.setTitleColor(.white, for: .normal)
      button.backgroundColor = #colorLiteral(red: 0.231372549, green: 0.1568627451, blue: 0.4274509804, alpha: 1)
      button.layer.cornerRadius = 6
      button.isEnabled = true
      button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
      button.translatesAutoresizingMaskIntoConstraints = false
      return button
    }()
    
    signUpButton = {
      let button = UIButton()
      button.setTitle("계정이 없으신가요?   가입하기", for: .normal)
      button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
      button.setTitleColor(#colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1), for: .normal)
      button.isEnabled = true
      button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
      button.translatesAutoresizingMaskIntoConstraints = false
      return button
    }()
  }
  
  func configureConstraints() {
    view.addSubview(logoImage)
    view.addSubview(logoLabel)
    view.addSubview(emailLabel)
    view.addSubview(emailPlaceHolderImage)
    view.addSubview(emailTextField)
    view.addSubview(emailBottomView)
    view.addSubview(passwordLabel)
    view.addSubview(passwordPlaceHolderImage)
    view.addSubview(passwordTextField)
    view.addSubview(passwordBottomView)
    view.addSubview(forgotPasswordButton)
    view.addSubview(loginButton)
    view.addSubview(signUpButton)
    
    NSLayoutConstraint.activate([
      logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 79),
      logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      
      logoLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 38),
      logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      logoLabel.heightAnchor.constraint(equalToConstant: 27),
      
      emailLabel.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 65),
      emailLabel.leadingAnchor.constraint(equalTo: emailBottomView.leadingAnchor),
      emailLabel.heightAnchor.constraint(equalToConstant: 15),
      
      emailPlaceHolderImage.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 16),
      emailPlaceHolderImage.leadingAnchor.constraint(equalTo: emailBottomView.leadingAnchor),
      emailPlaceHolderImage.heightAnchor.constraint(equalToConstant: 24),
      emailPlaceHolderImage.widthAnchor.constraint(equalToConstant: 19),
      
      emailTextField.topAnchor.constraint(equalTo: emailPlaceHolderImage.topAnchor),
      emailTextField.leadingAnchor.constraint(equalTo: emailPlaceHolderImage.trailingAnchor, constant: 15),
      emailTextField.trailingAnchor.constraint(equalTo: emailBottomView.trailingAnchor),
      emailTextField.heightAnchor.constraint(equalToConstant: 25),
      
      emailBottomView.topAnchor.constraint(equalTo: emailPlaceHolderImage.bottomAnchor, constant: 14),
      emailBottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
      emailBottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
      emailBottomView.heightAnchor.constraint(equalToConstant: 1),
      
      passwordLabel.topAnchor.constraint(equalTo: emailBottomView.bottomAnchor, constant: 30),
      passwordLabel.leadingAnchor.constraint(equalTo: passwordBottomView.leadingAnchor),
      passwordLabel.heightAnchor.constraint(equalToConstant: 15),
      
      passwordPlaceHolderImage.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 16),
      passwordPlaceHolderImage.leadingAnchor.constraint(equalTo: passwordBottomView.leadingAnchor),
      passwordPlaceHolderImage.heightAnchor.constraint(equalToConstant: 24),
      passwordPlaceHolderImage.widthAnchor.constraint(equalToConstant: 19),
      
      passwordTextField.topAnchor.constraint(equalTo: passwordPlaceHolderImage.topAnchor),
      passwordTextField.leadingAnchor.constraint(equalTo: passwordPlaceHolderImage.trailingAnchor, constant: 15),
      passwordTextField.trailingAnchor.constraint(equalTo: passwordBottomView.trailingAnchor),
      passwordTextField.heightAnchor.constraint(equalToConstant: 25),
      
      passwordBottomView.topAnchor.constraint(equalTo: passwordPlaceHolderImage.bottomAnchor, constant: 14),
      passwordBottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
      passwordBottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
      passwordBottomView.heightAnchor.constraint(equalToConstant: 1),
      
      forgotPasswordButton.topAnchor.constraint(equalTo: passwordBottomView.bottomAnchor, constant: 30),
      forgotPasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -55),
      forgotPasswordButton.heightAnchor.constraint(equalToConstant: 16),
      forgotPasswordButton.widthAnchor.constraint(equalToConstant: 81),
      
      loginButton.bottomAnchor.constraint(equalTo: signUpButton.topAnchor, constant: -20),
      loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 64),
      loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),
      loginButton.heightAnchor.constraint(equalToConstant: 53),
      
      signUpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
      signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      signUpButton.heightAnchor.constraint(equalToConstant: 16),
      signUpButton.widthAnchor.constraint(equalToConstant: 176)
    ])
  }
}
