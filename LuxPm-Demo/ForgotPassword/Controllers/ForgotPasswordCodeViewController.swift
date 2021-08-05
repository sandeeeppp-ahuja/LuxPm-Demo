//
//  ForgotPasswordCodeViewController.swift
//  LuxPm-Demo
//
//  Created by Sandeep on 05/08/21.
//

import UIKit
//import OTPFieldView

class ForgotPasswordCodeViewController: UIViewController {
  // MARK: - Properties
  lazy var logoImage = UIImageView()
  lazy var forgotPasswordLabel = UILabel()
  lazy var forgotPasswordSubLabel = UILabel()
  lazy var enterCodeLabel = UILabel()
  lazy var verifyCodeButton = UIButton()
  lazy var otpView = OTPStackView()
  
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
    setupView()
  }
  
  // MARK: - Helpers
  func setupView() {
    let email = viewModel.getSetEmail
    forgotPasswordSubLabel.text = "The code has been sent \(email)."
  }
  
  func configureBindings() {
    viewModel.showAlertClosure = { [weak self] title, message, completionHandler in
      DispatchQueue.main.async {
        self?.showAlertOK(title: title, message: message, completionHandler: completionHandler)
      }
    }
  }
  
  // MARK: - Actions
  @objc func verifyCodeTapped() {
    let viewController = NewPasswordViewController(viewModel: viewModel)
    navigationController?.pushViewController(viewController, animated: true)
  }
  
  @objc func doneButtonTapped() {
    view.endEditing(true)
  }
}

extension ForgotPasswordCodeViewController {
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
      label.text = "A code has been sent to your email"
      label.textAlignment = .center
      label.numberOfLines = 2
      label.font = UIFont.systemFont(ofSize: 23, weight: .medium)
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
    }()
    
    forgotPasswordSubLabel = {
      let label = UILabel()
      label.textColor = #colorLiteral(red: 0.7176470588, green: 0.7176470588, blue: 0.7176470588, alpha: 1)
      label.textAlignment = .center
      label.font = UIFont.systemFont(ofSize: 15)
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
    }()
    
    enterCodeLabel = {
      let label = UILabel()
      label.text = "Please enter the code below."
      label.textColor = #colorLiteral(red: 0.7176470588, green: 0.7176470588, blue: 0.7176470588, alpha: 1)
      label.textAlignment = .center
      label.font = UIFont.systemFont(ofSize: 15)
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
    }()
    
    otpView = {
      let view = OTPStackView()
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
    }()
    
    verifyCodeButton = {
      let button = UIButton()
      button.setTitle("Verify", for: .normal)
      button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
      button.setTitleColor(.white, for: .normal)
      button.backgroundColor = #colorLiteral(red: 0.231372549, green: 0.1568627451, blue: 0.4274509804, alpha: 1)
      button.layer.cornerRadius = 6
      button.isEnabled = true
      button.addTarget(self, action: #selector(verifyCodeTapped), for: .touchUpInside)
      button.translatesAutoresizingMaskIntoConstraints = false
      return button
    }()
  }
  
  func configureConstraints() {
    view.addSubview(logoImage)
    view.addSubview(forgotPasswordLabel)
    view.addSubview(forgotPasswordSubLabel)
    view.addSubview(enterCodeLabel)
    view.addSubview(otpView)
    view.addSubview(verifyCodeButton)
    
    NSLayoutConstraint.activate([
      logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 79),
      logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      
      forgotPasswordLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 40),
      forgotPasswordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
      forgotPasswordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
      
      forgotPasswordSubLabel.topAnchor.constraint(equalTo: forgotPasswordLabel.bottomAnchor, constant: 10),
      forgotPasswordSubLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      
      enterCodeLabel.topAnchor.constraint(equalTo: forgotPasswordSubLabel.bottomAnchor, constant: 5),
      enterCodeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      
      otpView.topAnchor.constraint(equalTo: enterCodeLabel.bottomAnchor, constant: 60),
      otpView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      
      verifyCodeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
      verifyCodeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 64),
      verifyCodeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),
      verifyCodeButton.heightAnchor.constraint(equalToConstant: 53)
    ])
  }
}

