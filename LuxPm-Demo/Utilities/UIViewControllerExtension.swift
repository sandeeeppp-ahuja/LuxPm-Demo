//
//  UIViewControllerExtension.swift
//  LuxPm-Demo
//
//  Created by Sandeep on 05/08/21.
//

import UIKit

extension UIViewController {
  // Pop back n number of controllers.
  func popControllers(_ number: Int, animate: Bool) {
    let viewsBack = number + 1
    if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
      guard viewControllers.count < viewsBack else {
        self.navigationController?.popToViewController(viewControllers[viewControllers.count - viewsBack], animated: animate)
        return
      }
    }
  }
}
