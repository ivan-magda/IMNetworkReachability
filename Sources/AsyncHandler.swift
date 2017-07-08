/**
 * Copyright (c) 2017 Ivan Magda
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Foundation
import SystemConfiguration

// MARK: AsyncHandler

class AsyncHandler {
  
  private let hostName: String
  private let reachability: SCNetworkReachability?
  
  /// Queue where the `SCNetworkReachability` callbacks run
  private let queue = DispatchQueue.main
  
  /// Keeps track of a backup of the last flags read
  private var currentReachabilityFlags: SCNetworkReachabilityFlags?
  
  private var isListening = false
  
  private var callback: IMNetworkCallback = { _ in }
  
  init(_ host: String) {
    hostName = host
    reachability = SCNetworkReachabilityCreateWithName(nil, host)
  }
  
  func start(_ callback: IMNetworkCallback?) {
    guard !isListening else { return }
    
    guard let reachability = reachability else {
      return self.callback(.error(.canNotInstantiateReachability))
    }
    
    if let callback = callback {
      self.callback = callback
    }
    
    var context = SCNetworkReachabilityContext(version: 0, info: nil, retain: nil,
                                               release: nil, copyDescription: nil)
    context.info = UnsafeMutableRawPointer(Unmanaged<AsyncHandler>.passUnretained(self).toOpaque())
    
    let callbackClosure = buildCallbackClosure()
    
    if !SCNetworkReachabilitySetCallback(reachability, callbackClosure, &context) {
      return self.callback(.error(.notAbleSetCallback))
    }
    
    if !SCNetworkReachabilitySetDispatchQueue(reachability, queue) {
      return self.callback(.error(.notAbleSetQueue))
    }
    
    queue.async {
      self.currentReachabilityFlags = nil
      
      var flags = SCNetworkReachabilityFlags()
      SCNetworkReachabilityGetFlags(reachability, &flags)
      
      self.checkReachability(flags: flags)
    }
    
    isListening = true
  }
  
  /// Stops listening
  func stop() {
    guard isListening, let reachability = reachability else { return }
    
    SCNetworkReachabilitySetCallback(reachability, nil, nil)
    SCNetworkReachabilitySetDispatchQueue(reachability, nil)
    
    isListening = false
  }
  
  // MARK: Private
  
  private func buildCallbackClosure() -> SCNetworkReachabilityCallBack? {
    let callbackClosure: SCNetworkReachabilityCallBack? = {
      (reachability: SCNetworkReachability, flags: SCNetworkReachabilityFlags, info: UnsafeMutableRawPointer?) in
      guard let info = info else { return }
      
      let handler = Unmanaged<AsyncHandler>.fromOpaque(info).takeUnretainedValue()
      
      DispatchQueue.main.async {
        handler.checkReachability(flags: flags)
      }
    }
    
    return callbackClosure
  }
  
  private func checkReachability(flags: SCNetworkReachabilityFlags) {
    if currentReachabilityFlags != flags {
      currentReachabilityFlags = flags
      
      let result: IMReachabilityResult = SyncEvaluator
        .isNetworkReachable(with: flags) ? .reachable : .offline
      self.callback(result)
    }
  }
  
}
