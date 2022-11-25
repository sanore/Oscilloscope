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

using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Oscilloscope.App.Ui.Core.WPF.Notify;

namespace Oscilloscope.App.Ui.Connection {
    public class OscilloscopeMgnt : OscilloscopeMgntIfc {
        private readonly List<OscilloscopeListenerIfc> m_listeners;

        /// <inheritdoc />
        public NotifyRefIfc<TriggerConfig> TriggerConfig { get; }

        /// <inheritdoc />
        public NotifyBoolIfc IsConnected { get; }

        /// <inheritdoc />
        public NotifyStringIfc StatusDescription { get; }

        /// <inheritdoc />
        public async Task StartRecord() {
            StatusDescription.Value = "Wait for Trigger...";

            var demo = new Record();
            for (int i = 0; i < 5000; i++) {
                var y = TriggerConfig.Value.Threshold.Value * Math.Sin(2 * Math.PI * i / 1000);
                demo.Add(i, y);
            }

            await Task.Delay(1500);

            m_listeners.ForEach(l => l.OnRecordReceived(demo));

            StatusDescription.Value = "Trigger Received";
        }

        /// <inheritdoc />
        public void AddListener(OscilloscopeListenerIfc listener) {
            if (!m_listeners.Contains(listener)) { m_listeners.Add(listener); }
        }

        public OscilloscopeMgnt() {
            StatusDescription = Notify.MakeString("Not connected");
            IsConnected = Notify.MakeBool(false);
            TriggerConfig = Notify.MakeRef(new TriggerConfig());

            m_listeners = new List<OscilloscopeListenerIfc>();

            // TODO remove
            IsConnected.ToggleAndGet();
        }
    }
}
