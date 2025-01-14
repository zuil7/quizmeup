//
//  View+Design.swift
//  QuizMeUp
//
//  Created by Louise on 10/20/21.
//  Copyright © 2021 Louise Nicolas Namoc. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
/// Computed properties, based on the backing CALayer property, that are visible in Interface Builder.
extension UIView {
  /// When positive, the background of the layer will be drawn with rounded corners. Also effects the mask generated by the `masksToBounds' property. Defaults to zero. Animatable.
  @IBInspectable var cornerRadius: Double {
    get {
      return Double(layer.cornerRadius)
    }
    set {
      layer.cornerRadius = CGFloat(newValue)
      // self.layer.masksToBounds = CGFloat(newValue) > 0
    }
  }

  /// The width of the layer's border, inset from the layer bounds. The border is composited above the layer's content and sublayers and includes the effects of the `cornerRadius' property. Defaults to zero. Animatable.
  @IBInspectable var borderWidth: Double {
    get {
      return Double(layer.borderWidth)
    }
    set {
      layer.borderWidth = CGFloat(newValue)
    }
  }

  /// The color of the layer's border. Defaults to opaque black. Colors created from tiled patterns are supported. Animatable.
  @IBInspectable var borderColor: UIColor? {
    get {
      return UIColor(cgColor: layer.borderColor!)
    }
    set {
      layer.borderColor = newValue?.cgColor
    }
  }

  /// The color of the shadow. Defaults to opaque black. Colors created from patterns are currently NOT supported. Animatable.
  @IBInspectable var shadowColor: UIColor? {
    get {
      return UIColor(cgColor: layer.shadowColor!)
    }
    set {
      layer.shadowColor = newValue?.cgColor
    }
  }

  /// The opacity of the shadow. Defaults to 0. Specifying a value outside the [0,1] range will give undefined results. Animatable.
  @IBInspectable var shadowOpacity: Float {
    get {
      return layer.shadowOpacity
    }
    set {
      layer.shadowOpacity = newValue
    }
  }

  /// The shadow offset. Defaults to (0, -3). Animatable.
  @IBInspectable var shadowOffset: CGSize {
    get {
      return layer.shadowOffset
    }
    set {
      layer.shadowOffset = newValue
    }
  }

  /// The blur radius used to create the shadow. Defaults to 3. Animatable.
  @IBInspectable var shadowRadius: Double {
    get {
      return Double(layer.shadowRadius)
    }
    set {
      layer.shadowRadius = CGFloat(newValue)
    }
  }

  /// The shouldRasterize bool used to give smooth scrolling when applied shadow to a layer.
  @IBInspectable var shouldRasterize: Bool {
    get {
      return layer.shouldRasterize
    }
    set {
      layer.shouldRasterize = newValue
    }
  }

  /// The shouldRasterize bool used to give smooth scrolling when applied shadow to a layer.
  @IBInspectable var rasterizationScale: CGFloat {
    get {
      return layer.rasterizationScale
    }
    set {
      layer.rasterizationScale = newValue
    }
  }
}
