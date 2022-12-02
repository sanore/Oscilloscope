// MIT License
// 
// Copyright (c) 2021 Oscilloscope
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

using System;
using System.Diagnostics.CodeAnalysis;

namespace Ost.PicoOsci.Ui.Core.WPF.Decorators {
    /// <summary>
    /// Object that implements the dispose pattern
    /// </summary>
    [ExcludeFromCodeCoverage]
    public abstract class DisposableObject : IDisposable {
        /// <summary>
        /// Is true is this object is disposed.
        /// </summary>
        public bool IsDisposed { get; private set; }

        /// <inheritdoc cref="IDisposable.Dispose" />
        /// <summary>
        /// </summary>
        public void Dispose() {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        /// <summary>
        /// Frees any unmanaged resources.
        /// </summary>
        protected virtual void DisposeUnmanaged() { }

        /// <summary>
        /// Frees any managed resources, your derived class has to override this in case:
        /// - the class manages any IDisposable objects
        /// - the class adds any event handlers
        /// - need to set references to to null to facilitate memory leak analysis via memory snapshot reference counts.
        /// Here, any event that has been registered through RegisterPropertyChangeHandler will be released.
        /// </summary>
        protected virtual void DisposeManaged() { }

        private void Dispose(bool isDisposing) {
            if (IsDisposed) {
                return;
            }

            if (isDisposing) {
                DisposeManaged();
            } // Free any managed resources in this section

            // Free any unmanaged resources in this section
            DisposeUnmanaged();
            IsDisposed = true;
        }
    }
}
