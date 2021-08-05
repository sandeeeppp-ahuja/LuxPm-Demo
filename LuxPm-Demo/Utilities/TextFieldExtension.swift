//
//  TextFieldExtension.swift
//  LuxPm-Demo
//
//  Created by Sandeep on 05/08/21.
//

import UIKit

class OTPTextField: UITextField {
  weak var previousTextField: OTPTextField?
  weak var nextTextField: OTPTextField?
  
  override public func deleteBackward(){
    text = ""
    previousTextField?.becomeFirstResponder()
  }
}
