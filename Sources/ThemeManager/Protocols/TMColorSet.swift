//
//  TMColor.swift
//
//
//  Created by Nevio Hirani on 03.01.24.
//

import Foundation
import SwiftUI

@available(iOS, introduced: 17)
/// A protocol defining a set of customizable colors for interface theming.
public protocol TMColorSet {
    var primaryColor: Color { get set }
    var secondaryColor: Color { get set }
    var accentColor: Color { get set }
    var backgroundColor: Color { get set }
    var textColor: Color { get set }
    var titleColor: Color { get set }
    var errorColor: Color { get set }
    var successColor: Color { get set }
    var warningColor: Color { get set }
    var linkColor: Color { get set }
    var disabledColor: Color { get set }
    var selectionColor: Color { get set }
    var overlayColor: Color { get set }
    var shadowColor: Color { get set }
    var borderColor: Color { get set }
}
