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

using System.IO.Ports;
using System.Threading;

namespace Oscilloscope.App.Ui.Oscilloscope.Uart {
    internal class Receiver {
        public Receiver(SerialPort port, UartReceiverSm receiver) {
            m_port                        =  port;
            m_receiver                    =  receiver;
            m_port.ReceivedBytesThreshold =  1;
            m_port.DataReceived           += OnDataReceived;

            m_cancellationTokenSource = new CancellationTokenSource();
            m_waiter                  = new ManualResetEventSlim();
        }

        public void Start() {
            m_thread = new Thread(Read);
            m_thread.Start();
        }

        public void Stop() {
            m_cancellationTokenSource.Cancel();
        }

        private void Read() {
            while (!m_cancellationTokenSource.IsCancellationRequested) {
                // Timeout for 10s
                m_waiter.Wait(10000);
                m_waiter.Reset();

                var bytesToRead = m_port.BytesToRead;

                if (bytesToRead <= 0) {
                    // Timeout ignore
                    continue;
                }

                for (var i = 0; i < bytesToRead; i++) {
                    var data = (byte)m_port.ReadByte();
                    m_receiver.Process(data);
                }
            }
        }

        private void OnDataReceived(object sender, SerialDataReceivedEventArgs e) {
            m_waiter.Set();
        }

        private readonly SerialPort              m_port;
        private readonly UartReceiverSm          m_receiver;
        private readonly ManualResetEventSlim    m_waiter;
        private readonly CancellationTokenSource m_cancellationTokenSource;
        private          Thread                  m_thread;
    }
}
