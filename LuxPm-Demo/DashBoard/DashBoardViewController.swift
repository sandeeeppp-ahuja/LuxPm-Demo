//
//  DashBoardViewController.swift
//  LuxPm-Demo
//
//  Created by Sandeep on 05/08/21.
//

import UIKit

class DashBoardViewController: UIViewController {
  // MARK: - Properties
  lazy var welcomeLabel = UILabel()
  lazy var logoutButton = UIButton()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViews()
    configureConstraints()
  }
  
  @objc func logoutTapped() {
    navigationController?.popViewController(animated: false)
  }
  
  func configureViews() {
    view.backgroundColor = .white
    
    welcomeLabel = {
      let label = UILabel()
      label.text = "Welcome"
      label.font = UIFont.systemFont(ofSize: 23)
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
    }()
    
    logoutButton = {
      let button = UIButton()
      button.setImage(UIImage(named: "logout"), for: .normal)
      button.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
      button.translatesAutoresizingMaskIntoConstraints = false
      return button
    }()
  }
  
  func configureConstraints() {
    view.addSubview(welcomeLabel)
    view.addSubview(logoutButton)
    
    NSLayoutConstraint.activate([
      welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      
      logoutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
      logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      logoutButton.heightAnchor.constraint(equalToConstant: 30),
      logoutButton.widthAnchor.constraint(equalToConstant: 30)
    ])
  }
}
