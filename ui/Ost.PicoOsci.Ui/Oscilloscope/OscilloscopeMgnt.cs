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

using System;
using System.Collections.Generic;
using System.Linq;
using Ost.PicoOsci.Ui.Core.WPF.Notify;
using Ost.PicoOsci.Ui.Core.Extensions;
using Ost.PicoOsci.Ui.Oscilloscope.Uart;

namespace Ost.PicoOsci.Ui.Oscilloscope {
    public class OscilloscopeMgnt : OscilloscopeMgntIfc, UartReceiverIfc {
        /// <inheritdoc />
        public NotifyRefIfc<TriggerConfig> TriggerConfig { get; }

        /// <inheritdoc />
        public NotifyBoolIfc IsConnected { get; }

        /// <inheritdoc />
        public NotifyStringIfc StatusDescription { get; }

        public OscilloscopeMgnt() {
            StatusDescription = Notify.MakeString("Not connected");
            IsConnected   = Notify.MakeBool(false);
            TriggerConfig = Notify.MakeRef(new TriggerConfig());

            m_listeners = new List<OscilloscopeListenerIfc>();
            m_uart = new UartConnection(this, port => new ComPort(port));
        }

        /// <inheritdoc />
        public void Connect(string comPort) {
            m_uart.Start(comPort);
            IsConnected.Value = true;
        }

        /// <inheritdoc />
        public void StartRecord() {
            if (!IsConnected.Value) { return; }

            StatusDescription.Value = "Wait for Trigger...";
            m_uart.SetTrigger(TriggerConfig.Value);
            m_uart.StartAcquire();
        }

        /// <inheritdoc />
        public void AddListener(OscilloscopeListenerIfc listener) {
            if (!m_listeners.Contains(listener)) { m_listeners.Add(listener); }
        }

        /// <inheritdoc />
        public void Error(Exception ex) {
            StatusDescription.Value = ex.Message;

            IsConnected.Value = false;
            m_uart.Stop();
        }

        /// <inheritdoc />
        public void OnAcquireStarted() {
            StatusDescription.Value = "Receiving data...";
        }

        /// <inheritdoc />
        public void OnAcquireCompleted(int triggerIdx, IList<byte> rawBytes) {
            StatusDescription.Value = "";

            float[] adcValues = new float[rawBytes.Count / 2];

            int countIdx = 0;
            for (int i = 0; i < rawBytes.Count; i += 2) {
                adcValues[countIdx++] = (rawBytes[i] << 8 | rawBytes[i + 1]) / 4095.0f; // convert to range 0..1V
            }

            var shiftFactor = (adcValues.Length / 2) - triggerIdx;
            var values = Extensions.Shift(adcValues, shiftFactor - 1);
            foreach (var listener in m_listeners) { listener.OnRecordReceived(new Record(adcValues.Length/2, values)); }
        }

        private readonly List<OscilloscopeListenerIfc> m_listeners;
        private readonly UartConnectionIfc             m_uart;
    }
}
