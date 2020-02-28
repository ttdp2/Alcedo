//
//  String+Extension.swift
//  AlcedoVaporPackageDescription
//
//  Created by Tian Tong on 2020/2/28.
//

import Foundation

extension String  {
    
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    
}
