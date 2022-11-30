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
using Ost.PicoOsci.Ui.Core.WPF.MVVM;
using Ost.PicoOsci.Ui.Oscilloscope;
using Syncfusion.UI.Xaml.Charts;

namespace Ost.PicoOsci.Ui.Presentation.RecordViewer.Chart {
    /// <summary>
    /// Represents the chart document view model.
    /// </summary>
    public class ChartViewModel : ViewModelBase<ChartControlIfc> {
        /// <summary>
        /// Gets a list of all series which are displayed in the chart.
        /// </summary>
        public ChartSeriesCollection Series { get; }

        /// <summary>
        /// Constructor.
        /// </summary>
        public ChartViewModel() {
            Series = new ChartSeriesCollection();
        }

        public void Render(Record record) {
            Series.Clear();
            Series.Add(new FastLineSeries {
                YBindingPath = record.BindingY,
                XBindingPath = record.BindingX,
                ItemsSource = record.Values,
                DataContext = record,
                EnableAnimation = true,
                AnimationDuration = TimeSpan.FromMilliseconds(500)
            });
        }
    }
}
