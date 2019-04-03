//
//  NibLoadableView.swift
//  Accorlex
//
//  Created by Barış Uyar on 3.04.2019.
//  Copyright © 2019 Barış Uyar. All rights reserved.
//

import Foundation

public protocol NibLoadableView: class {
    static var nibName: String { get }
}

public extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: Self.self)
    }
}
