//
//  ReuseIdentifierInterface.swift
//  FlickerVIPERTest
//
//  Created by Andres on 16/1/18.
//  Copyright © 2018 icologic. All rights reserved.
//

import Foundation
import UIKit

public protocol ReuseIdentifierInterface: class{
    //Obtenemos el identificador de la clase
    static var defaultReuseIdentifier : String { get }
}

public extension ReuseIdentifierInterface where Self: UIView{
    static var defaultReuseIdentifier : String{
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
