//
//  File.swift
//  
//
//  Created by Nevio Hirani on 03.01.24.
//

import SwiftUI

@frozen
/// A representation of a color that adapts to a given context.
public struct TMColor {
    
    var red: Float
    var green: Float
    var blue: Float
    
    @frozen
    /// A concrete color value.
    ///
    /// `TMColor.Resolved` is a set of RGBA values that represent a color that can be shown. The values are in Linear sRGB color space, extended range. This is a low-level type, most colors are represented by the Color type.
    /// - See also: `TMColor`
    public struct Resolved: Animatable, CustomStringConvertible, Decodable, Encodable, Equatable, Hashable, Sendable, ShapeStyle {
        public var description: String
        
        /// The amount of blue in the color in the sRGB color space.
        var blue: Float
        
        /// A Core Graphics representation of the color.
        ///
        /// You can get a CGColor instance from a resolved color.
        var cgColor: CGColor
        
        /// The amount of green in the color in the sRGB color space.
        var green: Float
        
        /// The amount of blue in the color in the sRGB linear color space.
        var linearBlue: Float
        
        /// The amount of green in the color in the sRGB linear color space.
        var linearGreen: Float
        
        /// The amount of red in the color in the sRGB linear color space.
        var linearRed: Float
        
        /// The degree of opacity in the color, given in the range 0 to 1.
        ///
        /// A value of 0 means 100% transparency, while a value of 1 means 100% opacity.
        var opacity: Float
        
        /// The amount of red in the color in the sRGB color space.
        var red: Float
        
        /// Coding keys to map properties during encoding and decoding.
        enum CodingKeys: CodingKey {
            case description, blue, cgColor, green, linearBlue, linearGreen, linearRed, opacity, red
        }
        
        /// Creates a resolved color from red, green, and blue component values.
        ///
        /// - Parameters:
        ///   - decoder: The decoder container that holds the encoded data.
        /// - Throws: An error if decoding fails or if the `CGColor` cannot be decoded properly.
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.description = try container.decode(String.self, forKey: .description)
            self.blue = try container.decode(Float.self, forKey: .blue)
            self.green = try container.decode(Float.self, forKey: .green)
            self.linearBlue = try container.decode(Float.self, forKey: .linearBlue)
            self.linearGreen = try container.decode(Float.self, forKey: .linearGreen)
            self.linearRed = try container.decode(Float.self, forKey: .linearRed)
            self.opacity = try container.decode(Float.self, forKey: .opacity)
            self.red = try container.decode(Float.self, forKey: .red)
            
            let cgColorData = try container.decode(Data.self, forKey: .cgColor)
            if let unarchivedCGColor = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: cgColorData) {
                self.cgColor = unarchivedCGColor.cgColor
            } else {
                throw DecodingError.dataCorruptedError(forKey: .cgColor, in: container, debugDescription: "Unable to decode CGColor")
            }
        }
        
        /// Creates a resolved color with specified attributes.
        ///
        /// - Parameters:
        ///   - description: A textual representation of the color.
        ///   - blue: The amount of blue in the color in the sRGB color space.
        ///   - cgColor: A Core Graphics representation of the color.
        ///   - green: The amount of green in the color in the sRGB color space.
        ///   - linearBlue: The amount of blue in the color in the sRGB linear color space.
        ///   - linearGreen: The amount of green in the color in the sRGB linear color space.
        ///   - linearRed: The amount of red in the color in the sRGB linear color space.
        ///   - opacity: The degree of opacity in the color.
        ///   - red: The amount of red in the color in the sRGB color space.
        public init(description: String, blue: Float, cgColor: CGColor, green: Float, linearBlue: Float, linearGreen: Float, linearRed: Float, opacity: Float, red: Float) {
            self.description = description
            self.blue = blue
            self.cgColor = cgColor
            self.green = green
            self.linearBlue = linearBlue
            self.linearGreen = linearGreen
            self.linearRed = linearRed
            self.opacity = opacity
            self.red = red
        }
        
        /// Encodes the properties of `TMColor.Resolved` into the provided encoder.
        ///
        /// - Parameters:
        ///   - encoder: The encoder container to encode the data.
        /// - Throws: An error if encoding fails, or if `UIColor` cannot be properly encoded as `Data`.
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(description, forKey: .description)
            try container.encode(blue, forKey: .blue)
            try container.encode(green, forKey: .green)
            try container.encode(linearBlue, forKey: .linearBlue)
            try container.encode(linearGreen, forKey: .linearGreen)
            try container.encode(linearRed, forKey: .linearRed)
            try container.encode(opacity, forKey: .opacity)
            try container.encode(red, forKey: .red)
            
            let archivedCGColorData = try NSKeyedArchiver.archivedData(withRootObject: UIColor(cgColor: cgColor), requiringSecureCoding: false)
            try container.encode(archivedCGColorData, forKey: .cgColor)
        }
    }
    
    init(red: Float, green: Float, blue: Float) {
        self.red = red
        self.green = green
        self.blue = blue
    }

    /// Creates a constant color with the values specified by the resolved color.
    static func fromResolved(resolved: Resolved) -> TMColor {
        return TMColor(red: resolved.red, green: resolved.green, blue: resolved.blue)
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
    
    func resolve(in environment: EnvironmentValues, description: String, red: Float, green: Float, blue: Float, opacity: Float) -> TMColor.Resolved {
        let resolvedColor = TMColor.Resolved(
            description: description,
            blue: blue,
            cgColor: UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1.0).cgColor,
            green: green,
            linearBlue: blue,
            linearGreen: green,
            linearRed: red,
            opacity: opacity,
            red: red
        )
        
        return resolvedColor
    }
}
