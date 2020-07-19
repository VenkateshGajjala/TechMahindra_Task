//
//  UIViewcontroller+Extension.swift
//  TechMahindraTask
//
//  Created by VijayaBhaskar on 18/07/20.
//  Copyright © 2020 Venkatesh. All rights reserved.
//

import UIKit

var vSpinner : UIView?
extension UIViewController {

    //CREATE ALERT VIEW
    func presentAlertWithTitle(title: String, message : String, vc: UIViewController) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        vc.present(alertController, animated: true)
    }
    
    //CREATE UIACTIVITYINDICATOR VIEW
    func showSpinner(onView : UIView) {
        DispatchQueue.main.async {
            let spinnerView = UIView.init(frame: onView.bounds)
            spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
            let ai = UIActivityIndicatorView.init(style: .whiteLarge)
            ai.startAnimating()
            ai.center = spinnerView.center
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
            vSpinner = spinnerView
        }
     }
    
    //REMOVE UIACTIVITYINDICATOR VIEW
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}


