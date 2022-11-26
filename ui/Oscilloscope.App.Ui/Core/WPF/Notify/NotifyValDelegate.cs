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

namespace Ost.PicoOsci.Ui.Core.WPF.Notify {
    /// <summary>
    /// Forwards a notify to another notify. Is useful if objectA to objectB has no 1:1 relationship.
    /// </summary>
    /// <typeparam name="T">The underlay type which is used to bind.</typeparam>
    internal class NotifyValDelegate<T> : NotifyBaseAbs, NotifyValIfc where T : struct {
        /// <summary>
        /// A forward construct to set or get the subordinate notify value.
        /// 
        /// Note: Use the <see cref="SetNotify" /> to change notify object.
        /// </summary>
        public new T Value {
            get => (T) ((NotifyValIfc) base.Value).Value;
            set => ((NotifyValIfc) base.Value).Value = value;
        }

        /// <summary>
        /// Constructor
        /// </summary>
        public NotifyValDelegate(T value) : this(new NotifyVal<T>(value)) {
            m_defaultValue = value;
        }

        /// <summary>
        /// Constructor.
        /// </summary>
        /// <param name="notify">Notify object</param>
        public NotifyValDelegate(NotifyValIfc<T> notify) {
            SetNotify(notify);
        }

        /// <inheritdoc cref="object.ToString" />
        public override string ToString() {
            return $"[NotifyProperty] Value:{Value}";
        }

        /// <summary>
        /// Sets the new notify object for this delegate.
        /// </summary>
        /// <param name="notify">The notify object to set.</param>
        public void SetNotify(NotifyValIfc<T> notify) {
            base.Value = notify;
        }

        /// <summary>
        /// Resets the binding to empty notify.
        /// </summary>
        public void Reset() {
            base.Value = new NotifyVal<T>(m_defaultValue);
        }

        private readonly T m_defaultValue;
    }
}
