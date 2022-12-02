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
using Ost.PicoOsci.Ui.Core.Extensions;

namespace Ost.PicoOsci.Ui.Oscilloscope.Uart {
    public class UartConnection : UartConnectionIfc {
        public UartConnection(UartReceiverIfc listener, Func<string, SerialPortIfc> portFactory) {
            m_listener = listener;
            m_portFactory = portFactory;
        }

        public void Start(string comPort) {
            try {
                m_port = m_portFactory(comPort);
                m_receiver = new Receiver(m_port, new UartReceiverSm(m_listener));
                m_sender   = new Sender(m_port);

                m_port.Open();
                m_receiver.Start();
            }
            catch (Exception ex) { m_listener.Error(ex); }
        }

        public void SetTrigger(TriggerConfig trigger) {
            var threshold = (short)trigger.Threshold.Value.Map(0, 0.5, 0, 4095);
            var data = new byte[4];
            data[0] = (byte)((threshold & 0x0FFF) >> 8);
            data[1] = (byte)(threshold & 0x00FF);
            // TODO EdgeSel & EdgeMode
            data[2] = 1; // (byte)(trigger.EdgeSel & 0x000F); // rising (0001), falling (0010), both/threshold (0011), ...
            data[3] = 0; // (byte)(trigger.EdgeMode & 0x000F); // EdgeMode=0

            Send(Tag.TriggerEdge, data);
        }

        public void StartAcquire() {
            Send(Tag.Start);
        }

        /// <inheritdoc />
        public void Stop() {
            m_receiver.Stop();
        }

        private void Send(Tag tag) {
            Send(tag, Array.Empty<byte>());
        }

        private void Send(Tag tag, byte[] data) {
            var buffer = new byte[2];

            if (data.Length > 0) {
                var newBuffer = new byte[data.Length + buffer.Length];
                data.CopyTo(newBuffer, buffer.Length);

                buffer = newBuffer;
            }

            var length = (byte)buffer.Length;
            buffer[0] = (byte)((byte)tag & 0xF);
            buffer[1] = (byte)(length & 0xFF);

            try { m_sender.Send(buffer); }
            catch (Exception ex) { m_listener.Error(ex); }
        }

        public enum Tag {
            Start       = 0b0001,
            Acquire     = 0b0010,
            TriggerEdge = 0b1000
        }

        private readonly UartReceiverIfc m_listener;
        private readonly Func<string, SerialPortIfc> m_portFactory;

        private SerialPortIfc m_port;
        private Receiver   m_receiver;
        private Sender     m_sender;
    }
}
