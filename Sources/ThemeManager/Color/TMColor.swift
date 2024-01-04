//
//  File.swift
//  
//
//  Created by Nevio Hirani on 03.01.24.
//

import SwiftUI

@frozen
public struct TMColor {
    
    @frozen
    /// A concrete color value.
    ///
    /// Color.Resolved is a set of RGBA values that represent a color that can be shown. The values are in Linear sRGB color space, extended range. This is a low-level type, most colors are represented by the Color type.
    /// > See also:
    /// > Color
    public struct Resolved: Animatable, CustomStringConvertible, Decodable, Encodable, Equatable, Hashable, Sendable, ShapeStyle {
        public var description: String
        public var blue: Float
        public var cgColor: CGColor
        public var green: Float
        public var linearBlue: Float
        public var linearGreen: Float
        public var linearRed: Float
        public var opacity: Float
        public var red: Float
        
        enum CodingKeys: CodingKey {
            case description, blue, cgColor, green, linearBlue, linearGreen, linearRed, opacity, red
        }
        
        /// Creates a resolved color from red, green, and blue component values.
        ///
        /// A standard sRGB color space clamps each color component — red, green, and blue — to a range of 0 to 1, but SwiftUI colors use an extended sRGB color space, so you can use component values outside that range. This makes it possible to create colors using the ``TMColor.RGBColorSpace.sRGB`` or ``TMColor.RGBColorSpace.sRGBLinear`` color space that make full use of the wider gamut of a diplay that supports ``TMColor.RGBColorSpace.displayP3``.
        public init(
            colorSpace: Color.RGBColorSpace = .sRGB,
            red: Float,
            green: Float,
            blue: Float,
            opacity: Float = 1
        ) {
            self.blue = blue
            self.cgColor = CGColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(opacity))
            self.green = green
            self.linearBlue = blue
            self.linearGreen = green
            self.linearRed = red
            self.opacity = opacity
            self.red = red
        }
        
        public func encode(to encoder: Encoder) throws {
            
        }
    }
    
    /// Creates a constant color with the values specified by the resolved color.
    init(_ resolved: ResolvedColor) { // FIXME: Rename to Resolved
        let redComponent = resolved.red > 1 ? Double(resolved.red) / 255.0 : resolved.red
        let greenComponent = resolved.green > 1 ? Double(resolved.green) / 255.0 : resolved.green
        let blueComponent = resolved.blue > 1 ? Double(resolved.blue) / 255.0 : resolved.blue
        
        self.init(
            red: redComponent,
            green: greenComponent,
            blue: blueComponent
        )
    }
    
    /// A profile that specifies how to interpret a color value for display
    @available(iOS, introduced: 13)
    @available(macOS, introduced: 10.15)
    @available(macCatalyst, introduced: 13)
    @available(tvOS, introduced: 13)
    @available(watchOS, introduced: 6)
    @available(visionOS, introduced: 1, message: "Beta")
    public enum RGBColorSpace: Equatable, Hashable, Sendable {
        /// The extended red, green, blue (sRGB) color space.
        ///
        /// For information about the sRGB colorimetry and nonlinear transform function, see the IEC 61966-2-1 specification.
        /// Standard sRGB color spaces clamp the red, green, and blue components of a color to a range of 0 to 1, but SwiftUI colors use an extended sRGB color space, so you can use component values outside that range.
        case sRGB
        
        /// The extended sRGB color space with a linear transfer function.
        ///
        /// This color space has the same colorimetry as ``TMColor.RGBColorSpace.sRGB`, but uses a linear transfer function.
        /// Standard sRGB color spaces clamp the red, green, and blue components of a color to a range of 0 to 1, but SwiftUI colors use an extended sRGB color space, so you can use component values outside that range.
        case sRGBLinear
        
        /// The display P3 color space.
        ///
        /// This color space uses the Digital Cinema Initiatives - Protocol 3 (DCI-P3) primary colors, a D65 white point, and the ``TMColor.RGBColorSpace.sRGB`` transfer function.
        case displayP3
    }
    
    /// Evaluates this color to a resolved color given the current context.
    func resolve(in environment: EnvironmentValues) -> Color.Resolved {
        let resolvedColor: ResolvedColor
        
        if environment.colorScheme == .dark {
            // Adjust color for dark mode
            resolvedColor = ResolvedColor(red: 0.1, green: 0.1, blue: 0.1)
        } else {
            // Use default color values for light mode
            resolvedColor = ResolvedColor(red: 1.0, green: 1.0, blue: 1.0)
        }
        
        return resolvedColor
    }
}
