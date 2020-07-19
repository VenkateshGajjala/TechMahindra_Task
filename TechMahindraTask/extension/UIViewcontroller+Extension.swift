//
//  UIViewcontroller+Extension.swift
//  TechMahindraTask
//
//  Created by VijayaBhaskar on 18/07/20.
//  Copyright © 2020 Venkatesh. All rights reserved.
//

import UIKit
extension UIViewController {
    func presentAlertWithTitle(title: String, message : String, vc: UIViewController) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        vc.present(alertController, animated: true)
    }
 
}


