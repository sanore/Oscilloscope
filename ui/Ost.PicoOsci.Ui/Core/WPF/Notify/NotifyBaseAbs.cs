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

using System.Diagnostics.CodeAnalysis;
using Ost.PicoOsci.Ui.Core.WPF.Decorators;

namespace Ost.PicoOsci.Ui.Core.WPF.Notify {
    /// <summary>
    /// Abstract base class for notification property. A notify property can bind to another one and will
    /// automatically updated if base property is changed.
    /// </summary>
    public abstract class NotifyBaseAbs : ObservableObject, NotifyIfc {
        /// <inheritdoc cref="NotifyIfc.Value" />
        /// <summary>
        /// </summary>
        public object Value {
            get => m_value;
            set => Set(ref m_value, value);
        }

        /// <inheritdoc cref="NotifyIfc.HasValue" />
        /// <summary>
        /// </summary>
        public virtual bool HasValue => m_value != null;

        /// <summary>
        /// Constructor.
        /// </summary>
        public NotifyBaseAbs() { }

        /// <summary>
        /// Constructor.
        /// </summary>
        /// <param name="value">initialize value</param>
        public NotifyBaseAbs(object value) {
            Value = value;
        }

        public override string ToString() {
            return $"[NotifyProperty] Value:{m_value}";
        }

        /// <inheritdoc cref="object.GetHashCode" />
        [SuppressMessage("ReSharper", "NonReadonlyMemberInGetHashCode")] // HashCode must be used from value object
        public override int GetHashCode() {
            return (m_value != null ? m_value.GetHashCode() : 0);
        }

        protected object m_value;
    }
}
