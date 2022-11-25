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
using DryIoc;

namespace Oscilloscope.App.Ui.Core.Docking {
    /// <summary>
    /// A namespace wrapper for different factory implementations
    /// </summary>
    public static class PanelFactory {
        /// <summary>
        /// A document factory, this creates a new viewmodel on each call.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        public class Document<T> : PanelFactoryIfc<T> where T : PanelViewModelIfc {
            /// <summary>
            /// Constructor
            /// </summary>
            /// <param name="application">the main ioc container</param>
            public Document(IContainer application) {
                m_application = application;
            }

            /// <inheritdoc />
            public T Create() {
                return m_application.New<T>();
            }

            private readonly IContainer m_application;
        }

        /// <summary>
        /// A panel factory, this returns always the same viewmodel.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        public class Panel<T> : PanelFactoryIfc<T> where T : PanelViewModelIfc {
            /// <summary>
            /// Constructor
            /// </summary>
            /// <param name="application">the main ioc container</param>
            public Panel(IContainer application) {
                m_viewModel = new Lazy<T>(() => application.New<T>());
            }

            /// <inheritdoc />
            public T Create() {
                return m_viewModel.Value;
            }

            private readonly Lazy<T> m_viewModel;
        }
    }
}
