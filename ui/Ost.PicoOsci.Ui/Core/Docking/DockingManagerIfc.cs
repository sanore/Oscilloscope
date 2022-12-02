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

using System.Collections.Generic;
using Ost.PicoOsci.Ui.Core.WPF.Notify;

namespace Ost.PicoOsci.Ui.Core.Docking {
    /// <summary>
    /// Docking manager with MVVM Pattern implementation.
    /// </summary>
    public interface DockingManagerIfc {
        /// <summary>
        /// Gets a list of all registered panels.
        /// </summary>
        ICollection<PanelViewModelIfc> Panels { get; }

        /// <summary>
        /// Gets the active document.
        /// </summary>
        NotifyRefIfc<PanelViewModelIfc> ActiveDocument { get; }

        /// <summary>
        /// Creates a new ViewModel with given type T and add it to Panels.
        /// Ensure a WPF DataTemplate is registered for given viewmodel type, otherwise the view doesn't know
        /// how to render the content.
        /// </summary>
        /// <typeparam name="T">The ViewModel type</typeparam>
        void Show<T>() where T : PanelViewModelIfc;
    }
}
