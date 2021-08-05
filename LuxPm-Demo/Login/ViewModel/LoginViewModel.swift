//
//  LoginViewModel.swift
//  LuxPm-Demo
//
//  Created by Sandeep Ahuja on 03/08/21.
//

import UIKit

class LoginViewModel {
  // MARK: - Properties
  private var email: String?
  private var password: String?
  var isEmailFormatValid = false
  var isPasswordValid = false
  
  // MARK: - Closures
  var showAlertClosure: ((String, String, ((UIAlertAction) -> Void)?) -> Void)?
  
  private func showOKAlert(title: String, message: String, completionHandler: ((UIAlertAction) -> Void)?) {
    self.showAlertClosure?(title, message, completionHandler)
  }
  
  // MARK: - Initalizer
  init() {
    print("[ARC DEBUG] Init LogInViewModel")
  }
  
  deinit {
    print("[ARC DEBUG] Deinit LogInViewModel")
  }
  
  // MARK: - Property Setters
  var getSetEmail: String {
    get {
      return email ?? ""
    }
    set(newValue) {
      email = newValue
    }
  }
  
  var getSetPassword: String {
    get {
      return password ?? ""
    }
    set(newValue) {
      password = newValue
    }
  }
  
  // MARK: - Methods
  func validateEmail(email: String) {
    if email.isEmailValid {
      isEmailFormatValid = true
      getSetEmail = email
    } else {
      isEmailFormatValid = false
    }
  }
  
  func validatePassword(password: String) {
    // Minimun password length = 3
    if password.count > 3 {
      isPasswordValid = true
      getSetPassword = password
    } else {
      isPasswordValid = false
    }
  }
  
  func loginUser(email: String, password: String, completion: @escaping((Bool) -> Void)) {
    if isEmailFormatValid && isPasswordValid {
      if email == Constants.email && password == Constants.password {
        completion(true)
      } else {
        self.showOKAlert(title: "OhNo", message: "Please enter correct credentials", completionHandler: nil)
      }
    } else {
      self.showOKAlert(title: "OhNo", message: "The format is wrong", completionHandler: nil)
    }
      
  }
  
}
