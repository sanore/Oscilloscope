// MIT License
// 
// Copyright (c) 2021 LinearSPICE
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

namespace Oscilloscope.App.Ui.Core.WPF.Notify {
    /// <summary>
    ///     <inheritdoc cref="NotifyValIfc" />
    /// </summary>
    internal class NotifyVal<T> : NotifyBaseAbs, NotifyValIfc<T> where T : struct {
        /// <inheritdoc cref="NotifyIfc.Value" />
        /// <summary>
        /// Overwrites the value to a specific type
        /// </summary>
        public new T Value {
            get => (T) m_value;
            set => base.Value = value;
        }

        /// <inheritdoc cref="NotifyIfc.HasValue" />
        /// <summary>
        /// </summary>
        public override bool HasValue => true;

        /// <summary>
        /// Constructor.
        /// </summary>
        /// <param name="value"></param>
        public NotifyVal(T value) : base(value) { }
    }
}
