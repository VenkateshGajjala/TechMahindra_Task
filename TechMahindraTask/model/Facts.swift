//
//  Facts.swift
//  TechMahindraTask
//
//  Created by Venkatesh on 18/07/20.
//  Copyright © 2020 Venkatesh. All rights reserved.
//

import Foundation
import UIKit

struct Facts:Codable {
    let title: String
    let rows: [Rows]?
}

struct Rows:Codable {
    var title: String?
    var description: String?
    var imageHref: String?
}
