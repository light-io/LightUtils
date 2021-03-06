// Copyright (c) 2021 light-io
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation

@propertyWrapper
public final class Atomic<Value> {

    public var projectedValue: Atomic<Value> { self }

    public var wrappedValue: Value {
        get {
            queue.sync { self.value }
        }
        set {
            queue.sync { self.value = newValue }
        }
    }

    private let queue = DispatchQueue("atomic_queue_for_\(Value.self)", concurrency: .serial)
    private var value: Value

    public init(wrappedValue: Value) {
        self.value = wrappedValue
    }

    public func mutate(_ transform: (inout Value) -> Void) {
        queue.sync { transform(&self.value) }
    }
}
