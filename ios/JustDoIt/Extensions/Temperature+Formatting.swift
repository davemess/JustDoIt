//
//  Temperature+Formatting.swift
//  JustDoIt
//
//  Created by David Messing on 5/20/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation
import WeatherService

extension Temperature: CustomStringConvertible {
    
    public var description: String {
        // TODO: Use a proper formatter and consider localization.
        let valueString = String(format: "%.0f", value)
        let unitSting: String
        
        switch unit {
        case .kelvin:
            unitSting = NSLocalizedString("Kelvin", comment: "")
        case .celsius:
            unitSting = NSLocalizedString("Celsius", comment: "")
        case .fahrenheit:
            unitSting = NSLocalizedString("Fahrenheit", comment: "")
        }
        
        let string = String(format: "%@ %@", valueString, unitSting)
        return string
    }
    
}
