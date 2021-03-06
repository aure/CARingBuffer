//
//  DispatchOnce.swift
//  mcCore
//
//  Created by Vlad Gorlov on 10/01/2017.
//  Copyright © 2017 WaveLabs. All rights reserved.
//

import Foundation

public final class DispatchOnce {

   private var isInitialized = false

   public init() {
   }

   public func perform(block: () -> Void) {
      if !isInitialized {
         block()
         isInitialized = true
      }
   }
}
