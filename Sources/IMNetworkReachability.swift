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

// MARK: IMNetworkReachability

public class IMNetworkReachability {
  
  // MARK: Instance Variables
  
  fileprivate let hostName: String
  fileprivate let asyncHandler: AsyncHandler
  
  // MARK: Init
  
  public init(_ host: String) {
    hostName = host
    asyncHandler = AsyncHandler(host)
  }
  
}

// MARK: - IMNetworkReachability (IMNetworkReachable) -

extension IMNetworkReachability: IMNetworkReachable {
  
  public func isReachable() -> IMReachabilityResult {
    return SyncEvaluator.isReachable(for: hostName)
  }
  
  public func startListening(_ callback: @escaping IMNetworkCallback) {
    asyncHandler.start(callback)
  }
  
  public func stopListening() {
    asyncHandler.stop()
  }
  
}
