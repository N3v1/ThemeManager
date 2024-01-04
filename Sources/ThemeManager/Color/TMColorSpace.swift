//
//  File.swift
//  
//
//  Created by Nevio Hirani on 03.01.24.
//

import Foundation

/// A profile that specifies how to interpret a color value for display
@available(iOS, introduced: 13)
@available(macOS, introduced: 10.15)
@available(macCatalyst, introduced: 13)
@available(tvOS, introduced: 13)
@available(watchOS, introduced: 6)
@available(visionOS, introduced: 1, message: "Beta")
public enum TMRGBColorSpace: Equatable, Hashable, Sendable {
    /// The extended red, green, blue (sRGB) color space.
    case sRGB
    
    /// The extended sRGB color space with a linear transfer function.
    case sRGBLinear
    
    /// The display P3 color space.
    case displayP3
}
