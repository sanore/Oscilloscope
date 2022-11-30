// MIT License
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

using Ost.PicoOsci.Ui.Core.Actions;
using Ost.PicoOsci.Ui.Presentation.RecordViewer;

namespace Ost.PicoOsci.Ui.Oscilloscope.Actions {
    public class StartRecordAction : AnAction {
        public const string ID = "Record.Start";

        /// <inheritdoc />
        public StartRecordAction(OscilloscopeMgntIfc oscilloscope, RecordViewerPanelViewModel viewModel) : base(ID) {
            m_oscilloscope = oscilloscope;
            this.viewModel = viewModel;
        }

        /// <inheritdoc />
        protected override bool CanExecute(AnActionEvent args) {
            return true;
        }

        /// <inheritdoc />
        protected override void Execute(AnActionEvent args) {
            if (!m_oscilloscope.IsConnected.Value) {
                var comPort = args.GetParameter<string>();
                m_oscilloscope.Connect(comPort);
            }

            viewModel.Clear();
            m_oscilloscope.StartRecord();
        }

        private readonly OscilloscopeMgntIfc m_oscilloscope;
        private readonly RecordViewerPanelViewModel viewModel;
    }
}
