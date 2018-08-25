//
//  MediaBufferList.swift
//  WaveLabs
//
//  Created by Vlad Gorlov on 08.09.16.
//  Copyright © 2016 WaveLabs. All rights reserved.
//

import Foundation

public struct MediaBufferList<T> {

   public let numberOfBuffers: UInt
   public let buffers: UnsafePointer<MediaBuffer<T>>
   public let mutableBuffers: UnsafeMutablePointer<MediaBuffer<T>>

   public init(mutableBuffers: UnsafeMutablePointer<MediaBuffer<T>>, numberOfBuffers: Int) {
      self.numberOfBuffers = UInt(numberOfBuffers)
      self.mutableBuffers = mutableBuffers
      buffers = UnsafePointer(mutableBuffers)
   }

   public init(buffers: UnsafePointer<MediaBuffer<T>>, numberOfBuffers: Int) {
      self.numberOfBuffers = UInt(numberOfBuffers)
      mutableBuffers = UnsafeMutablePointer(mutating: buffers)
      self.buffers = buffers
   }

   public subscript(index: UInt) -> UnsafePointer<MediaBuffer<T>> {
      precondition(index < numberOfBuffers)
      return buffers.advanced(by: Int(index))
   }

   public var arrayOfBuffers: [MediaBuffer<T>] {
      var result: [MediaBuffer<T>] = []
      for index in 0 ..< numberOfBuffers {
         result.append(self[index].pointee)
      }
      return result
   }
}
