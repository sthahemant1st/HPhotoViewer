//
//  Optionsl+Extension.swift
//  PhotoViewer
//
//  Created by Hemant Shrestha on 24/08/2022.
//

import Foundation

extension Optional {
    var isNil: Bool {
        return self == nil
    }
    var hasValue: Bool {
        return !isNil
    }
}
