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
using System.IO.Ports;

namespace Oscilloscope.App.Ui.Oscilloscope.Uart {
    public class UartConnection : UartConnectionIfc {
        public UartConnection(UartReceiverIfc listener) {
            m_listener = listener;
        }

        public void Start(string comPort) {
            try {
                m_port     = new SerialPort(comPort, 115200, Parity.Even, 8, StopBits.One);
                m_receiver = new Receiver(m_port, new UartReceiverSm(m_listener));
                m_sender   = new Sender(m_port);

                m_receiver.Start();
            }
            catch (Exception ex) { m_listener.Error(ex); }
        }

        public void SetTrigger(TriggerConfig trigger) {
            var threshold = (short)(trigger.Threshold.Value * short.MaxValue / 2) + short.MaxValue / 2;
            var data = new byte[2];
            data[0] = (byte)((threshold >> 8) & 0xFF00);
            data[1] = (byte)(threshold & 0xFF00);

            Send(Tag.Threshold, data);

            // TODO EdgeSel & EdgeMode
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
            var length = (byte)data.Length;
            const int toDevice = 0;
            buffer[0] = (byte)((((byte)tag & 0xF) << 4) | toDevice);
            buffer[1] = (byte)(length & 0xFF);

            if (length > 0) {
                var newBuffer = new byte[data.Length + buffer.Length];
                buffer.CopyTo(newBuffer, 0);
                data.CopyTo(newBuffer, buffer.Length);

                buffer = newBuffer;
            }

            try { m_sender.Send(buffer); }
            catch (Exception ex) { m_listener.Error(ex); }
        }

        public enum Tag {
            Start     = 0b0000,
            Acquire   = 0b0010,
            Threshold = 0b1000,
            EdgeSel   = 0b1100,
            EdgeMode  = 0b1110
        }

        private readonly UartReceiverIfc m_listener;

        private SerialPort m_port;
        private Receiver   m_receiver;
        private Sender     m_sender;
    }
}
