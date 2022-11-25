﻿// MIT License
//
// Copyright (c) 2022 LinearSPICE
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

using Oscilloscope.App.Ui.Connection;
using Oscilloscope.App.Ui.Core.Docking;
using Syncfusion.Windows.Tools.Controls;

namespace Oscilloscope.App.Ui.Presentation.TriggerCfg {
    public class TriggerCfgPanelViewModel : PanelViewModel {
        private readonly OscilloscopeMgntIfc m_oscilloscope;

        /// <inheritdoc />
        public TriggerCfgPanelViewModel(OscilloscopeMgntIfc oscilloscope) : base("Trigger Config", DockSide.Left) {
            m_oscilloscope = oscilloscope;
        }
    }
}
