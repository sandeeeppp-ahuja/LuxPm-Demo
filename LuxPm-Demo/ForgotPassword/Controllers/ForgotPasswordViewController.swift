//
//  ForgotPasswordViewController.swift
//  LuxPm-Demo
//
//  Created by Sandeep on 05/08/21.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
  // MARK: - Properties
  lazy var logoImage = UIImageView()
  lazy var forgotPasswordLabel = UILabel()
  lazy var forgotPasswordSubLabel = UILabel()
  lazy var emailLabel = UILabel()
  lazy var emailPlaceHolderImage = UIImageView()
  lazy var emailTextField = UITextField()
  lazy var emailBottomView = UIView()
  lazy var submitEmailButton = UIButton()
  
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
  @objc func submitEmailTapped() {
    let email = viewModel.getSetEmail
    viewModel.submitEmail(email: email) { status in
      if status {
        let viewController = ForgotPasswordCodeViewController(viewModel: self.viewModel)
        self.navigationController?.pushViewController(viewController, animated: true)
      }
    }
  }
  
  @objc func doneButtonTapped() {
    view.endEditing(true)
  }
}

extension ForgotPasswordViewController: UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField) {
    guard let textFieldText = textField.text else { return }
    viewModel.validateEmail(email: textFieldText)
  }
}

extension ForgotPasswordViewController {
  func configureViews() {
    view.backgroundColor = .white
    
    logoImage = {
      let image = UIImage(named: "gradation")
      let imageView = UIImageView(image: image)
      imageView.contentMode = .scaleAspectFit
      imageView.translatesAutoresizingMaskIntoConstraints = false
      return imageView
    }()
    
    forgotPasswordLabel = {
      let label = UILabel()
      label.text = "Forgot Password?"
      label.textAlignment = .center
      label.font = UIFont.systemFont(ofSize: 23, weight: .medium)
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
    }()
    
    forgotPasswordSubLabel = {
      let label = UILabel()
      label.text = "Please enter the email associated to your account."
      label.textColor = #colorLiteral(red: 0.7176470588, green: 0.7176470588, blue: 0.7176470588, alpha: 1)
      label.textAlignment = .center
      label.numberOfLines = 2
      label.font = UIFont.systemFont(ofSize: 15)
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
    
    submitEmailButton = {
      let button = UIButton()
      button.setTitle("Submit Email", for: .normal)
      button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
      button.setTitleColor(.white, for: .normal)
      button.backgroundColor = #colorLiteral(red: 0.231372549, green: 0.1568627451, blue: 0.4274509804, alpha: 1)
      button.layer.cornerRadius = 6
      button.isEnabled = true
      button.addTarget(self, action: #selector(submitEmailTapped), for: .touchUpInside)
      button.translatesAutoresizingMaskIntoConstraints = false
      return button
    }()
  }
  
  func configureConstraints() {
    view.addSubview(logoImage)
    view.addSubview(forgotPasswordLabel)
    view.addSubview(forgotPasswordSubLabel)
    view.addSubview(emailLabel)
    view.addSubview(emailPlaceHolderImage)
    view.addSubview(emailTextField)
    view.addSubview(emailBottomView)
    view.addSubview(submitEmailButton)
    
    NSLayoutConstraint.activate([
      logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 79),
      logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      
      forgotPasswordLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 40),
      forgotPasswordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      forgotPasswordLabel.heightAnchor.constraint(equalToConstant: 27),
      
      forgotPasswordSubLabel.topAnchor.constraint(equalTo: forgotPasswordLabel.bottomAnchor, constant: 10),
      forgotPasswordSubLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
      forgotPasswordSubLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
      
      emailLabel.topAnchor.constraint(equalTo: forgotPasswordSubLabel.bottomAnchor, constant: 50),
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
      
      submitEmailButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
      submitEmailButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 64),
      submitEmailButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),
      submitEmailButton.heightAnchor.constraint(equalToConstant: 53)
    ])
  }
}
