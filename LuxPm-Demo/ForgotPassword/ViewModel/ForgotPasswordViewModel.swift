//
//  ForgotPasswordViewModel.swift
//  LuxPm-Demo
//
//  Created by Sandeep on 05/08/21.
//

import UIKit

class ForgotPasswordViewModel {
  // MARK: - Properties
  private var email: String?
  var isEmailFormatValid = false
  
  
  
  // MARK: - Closures
  var showAlertClosure: ((String, String, ((UIAlertAction) -> Void)?) -> Void)?
  
  private func showOKAlert(title: String, message: String, completionHandler: ((UIAlertAction) -> Void)?) {
    self.showAlertClosure?(title, message, completionHandler)
  }
  
  // MARK: - Initalizer
  init() {
    print("[ARC DEBUG] Init ForgotPasswordViewModel")
  }
  
  deinit {
    print("[ARC DEBUG] Deinit ForgotPasswordViewModel")
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
  
  // MARK: - Methods
  func validateEmail(email: String) {
    if email.isEmailValid {
      isEmailFormatValid = true
      getSetEmail = email
    } else {
      isEmailFormatValid = false
    }
  }
  
  func submitEmail(email: String, completion: @escaping((Bool) -> Void)) {
    if isEmailFormatValid {
      completion(true)
    } else {
      self.showOKAlert(title: "OhNo", message: "The format is wrong", completionHandler: nil)
    }
  }
}
