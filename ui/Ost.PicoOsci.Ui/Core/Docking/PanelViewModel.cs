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

using Ost.PicoOsci.Ui.Core.WPF.MVVM;
using Syncfusion.Windows.Tools.Controls;

namespace Ost.PicoOsci.Ui.Core.Docking {
    /// <summary>
    /// A PanelViewModel
    /// </summary>
    public abstract class PanelViewModel : ViewModelBase, PanelViewModelIfc {
        /// <inheritdoc />
        public DockState InitialState { get; }

        /// <inheritdoc />
        public DockSide InitialPosition { get; }

        /// <inheritdoc />
        public string Header { get; }

        /// <inheritdoc />
        public PanelViewModel(string header, DockSide side, DockState state = DockState.Dock) {
            InitialState = state;
            InitialPosition = side;

            Header = header;
        }
    }
}
