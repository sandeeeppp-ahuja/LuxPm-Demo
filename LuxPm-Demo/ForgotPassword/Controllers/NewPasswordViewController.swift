//
//  NewPasswordViewController.swift
//  LuxPm-Demo
//
//  Created by Sandeep on 05/08/21.
//

import UIKit

class NewPasswordViewController: UIViewController {
  // MARK: - Properties
  lazy var logoImage = UIImageView()
  lazy var enterNewPasswordLabel = UILabel()
  lazy var newPasswordLabel = UILabel()
  lazy var passwordPlaceHolderImage = UIImageView()
  lazy var passwordTextField = UITextField()
  lazy var passwordBottomView = UIView()
  lazy var setNewPasswordButton = UIButton()
  
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
  
  private let viewModel: ForgotPasswordViewModel
  // MARK: - LifeCycle
  
  init(viewModel: ForgotPasswordViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
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
  @objc func setNewPasswordTapped() {
    self.popControllers(3, animate: false)
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

extension NewPasswordViewController: UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField) {
    guard let textFieldText = textField.text else { return }
    viewModel.validateEmail(email: textFieldText)
  }
}

extension NewPasswordViewController {
  func configureViews() {
    view.backgroundColor = .white
    
    logoImage = {
      let image = UIImage(named: "gradation")
      let imageView = UIImageView(image: image)
      imageView.contentMode = .scaleAspectFit
      imageView.translatesAutoresizingMaskIntoConstraints = false
      return imageView
    }()
    
    enterNewPasswordLabel = {
      let label = UILabel()
      label.text = "Enter New Password"
      label.textAlignment = .center
      label.font = UIFont.systemFont(ofSize: 23, weight: .medium)
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
    }()
    
    newPasswordLabel = {
      let label = UILabel()
      label.text = "New Password"
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
    
    setNewPasswordButton = {
      let button = UIButton()
      button.setTitle("Submit Email", for: .normal)
      button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
      button.setTitleColor(.white, for: .normal)
      button.backgroundColor = #colorLiteral(red: 0.231372549, green: 0.1568627451, blue: 0.4274509804, alpha: 1)
      button.layer.cornerRadius = 6
      button.isEnabled = true
      button.addTarget(self, action: #selector(setNewPasswordTapped), for: .touchUpInside)
      button.translatesAutoresizingMaskIntoConstraints = false
      return button
    }()
  }
  
  func configureConstraints() {
    view.addSubview(logoImage)
    view.addSubview(enterNewPasswordLabel)
    view.addSubview(newPasswordLabel)
    view.addSubview(passwordPlaceHolderImage)
    view.addSubview(passwordTextField)
    view.addSubview(passwordBottomView)
    view.addSubview(setNewPasswordButton)
    
    NSLayoutConstraint.activate([
      logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 79),
      logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      
      enterNewPasswordLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 40),
      enterNewPasswordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      enterNewPasswordLabel.heightAnchor.constraint(equalToConstant: 27),
      
      newPasswordLabel.topAnchor.constraint(equalTo: enterNewPasswordLabel.bottomAnchor, constant: 50),
      newPasswordLabel.leadingAnchor.constraint(equalTo: passwordBottomView.leadingAnchor),
      newPasswordLabel.heightAnchor.constraint(equalToConstant: 15),
      
      passwordPlaceHolderImage.topAnchor.constraint(equalTo: newPasswordLabel.bottomAnchor, constant: 16),
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
      
      setNewPasswordButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
      setNewPasswordButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 64),
      setNewPasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),
      setNewPasswordButton.heightAnchor.constraint(equalToConstant: 53)
    ])
  }
}
