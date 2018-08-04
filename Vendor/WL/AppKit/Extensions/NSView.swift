//
//  NSView.swift
//  WLUI
//
//  Created by Vlad Gorlov on 12.08.17.
//  Copyright © 2017 Demo. All rights reserved.
//

import AppKit

extension NSView {

   public func addSubviews(_ views: NSView...) {
      for view in views {
         addSubview(view)
      }
   }

   public func addSubviews(_ views: [NSView]) {
      for view in views {
         addSubview(view)
      }
   }

   public func removeSubviews() {
      subviews.forEach { $0.removeFromSuperview() }
   }

   public var recursiveSubviews: [NSView] {
      var result = subviews
      for subview in subviews {
         result += subview.recursiveSubviews
      }
      return result
   }

   public func withFocus(drawingCalls: (() -> Void)) {
      lockFocus()
      drawingCalls()
      unlockFocus()
   }
}

extension NSView {

   public var verticalContentCompressionResistancePriority: NSLayoutConstraint.Priority {
      get {
         return contentCompressionResistancePriority(for: .vertical)
      } set {
         setContentCompressionResistancePriority(newValue, for: .vertical)
      }
   }

   public var horizontalContentCompressionResistancePriority: NSLayoutConstraint.Priority {
      get {
         return contentCompressionResistancePriority(for: .horizontal)
      } set {
         setContentCompressionResistancePriority(newValue, for: .horizontal)
      }
   }

   public var verticalContentHuggingPriority: NSLayoutConstraint.Priority {
      get {
         return contentHuggingPriority(for: .vertical)
      } set {
         setContentHuggingPriority(newValue, for: .vertical)
      }
   }

   public var horizontalContentHuggingPriority: NSLayoutConstraint.Priority {
      get {
         return contentHuggingPriority(for: .horizontal)
      } set {
         setContentHuggingPriority(newValue, for: .horizontal)
      }
   }
}

extension NSView {

   public func autolayoutView() -> Self {
      translatesAutoresizingMaskIntoConstraints = false
      return self
   }

   /// Prints results of internal Apple API method `_subtreeDescription` to console.
   public func dump() {
      let value = perform(Selector(("_subtreeDescription")))
      Swift.print(String(describing: value))
   }

   public func autolayoutTrace() {
      let value = perform(Selector(("_autolayoutTrace")))
      Swift.print(String(describing: value))
   }

   public var ambiguousSubviews: [NSView] {
      guard BuildInfo.isDebug else {
         return []
      }
      let result = recursiveSubviews.filter { $0.hasAmbiguousLayout }
      return result
   }

   public func assertOnAmbiguityInSubviewsLayout() {
      guard BuildInfo.isDebug else {
         return
      }
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
         let value = self.ambiguousSubviews
         value.forEach {
            print("- " + $0.debugDescription)
            $0.autolayoutTrace()
         }
         assert(value.isEmpty)
      }
   }
}
