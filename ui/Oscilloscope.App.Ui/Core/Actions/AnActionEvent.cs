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

using System;

namespace Ost.PicoOsci.Ui.Core.Actions {
    /// <summary>
    /// The action arguments.
    /// </summary>
    public class AnActionEvent : EventArgs {
        /// <summary>
        /// Constructor.
        /// </summary>
        /// <param name="parameter">The parameter for this action</param>
        public AnActionEvent(object parameter = null) {
            m_parameter = parameter;
        }

        /// <summary>
        /// Gets the WPF CommandParameter binded object.
        /// </summary>
        /// <typeparam name="T">Expected type</typeparam>
        /// <returns>Casted type or null if not possible.</returns>
        public T GetParameter<T>() {
            return m_parameter is T variable ? variable : default(T);
        }

        private readonly object m_parameter;
    }
}
