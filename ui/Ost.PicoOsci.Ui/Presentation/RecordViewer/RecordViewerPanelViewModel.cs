// MIT License
//
// Copyright (c) 2022 Oscilloscope
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

using DryIoc;
using Ost.PicoOsci.Ui.Core.Docking;
using Ost.PicoOsci.Ui.Oscilloscope;
using Ost.PicoOsci.Ui.Presentation.RecordViewer.Chart;
using Syncfusion.Windows.Tools.Controls;
using System.Windows;

namespace Ost.PicoOsci.Ui.Presentation.RecordViewer {
    public class RecordViewerPanelViewModel : PanelViewModel, OscilloscopeListenerIfc {
        public ChartViewModel ChartVm { get; }

        /// <inheritdoc />
        public RecordViewerPanelViewModel(IContainer app, OscilloscopeMgntIfc oscilloscope) : base("Record", DockSide.None, DockState.Document) {
            oscilloscope.AddListener(this);

            ChartVm = app.New<ChartViewModel>();
        }

        /// <inheritdoc />
        public void OnRecordReceived(Record record) {
            Application.Current?.Dispatcher.Invoke(() => {
                ChartVm.Render(record);
            });
        }

        public void Clear() {
            ChartVm.Clear();
        }
    }
}
