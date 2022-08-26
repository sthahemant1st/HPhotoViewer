//
//  Itendifiable.swift
//  PhotoViewer
//
//  Created by Hemant Shrestha on 24/08/2022.
//

import Foundation

protocol Identifiable {}

extension Identifiable {
    static var identifier: String {
        return String(describing: Self.self)
    }
}
