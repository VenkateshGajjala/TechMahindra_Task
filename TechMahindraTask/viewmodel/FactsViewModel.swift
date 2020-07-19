//
//  FactsViewModel.swift
//  TechMahindraTask
//
//  Created by VijayaBhaskar on 18/07/20.
//  Copyright © 2020 Venkatesh. All rights reserved.
//

import UIKit

class FactsViewModel: NSObject {
    var factsDataList:[Rows]?
    var title : String?
    
    func fetchData(vc:UIViewController, success: @escaping (Bool)->()) {
        if Reachability.isConnectedToNetwork() {
            guard let url = URL(string: API.GET.FACTS_API) else { return }
            let session = URLSession.shared
            let task = session.dataTask(with: url) { (data, response, error) in
                vc.removeSpinner()
                guard let data = data else { return }
                guard let string = String(data: data, encoding: String.Encoding.isoLatin1) else { return }
                guard let properData = string.data(using: .utf8, allowLossyConversion: true) else { return }
                do{
                    let factObject  = try JSONDecoder().decode(Facts.self, from: properData)
                    self.factsDataList = factObject.rows!
                    self.title = factObject.title
                    success(true)
                } catch {
                    vc.presentAlertWithTitle(title: "Error", message: "Something went wrong", vc: vc)
                    success(false)
                }
            }
            task.resume()
        }else{
            vc.removeSpinner()
            vc.presentAlertWithTitle(title: "Network error", message: "Unable to connect to the internet. Please check your Wi-Fi or Cellular data Settings", vc: vc)
        }
        
    }


}
