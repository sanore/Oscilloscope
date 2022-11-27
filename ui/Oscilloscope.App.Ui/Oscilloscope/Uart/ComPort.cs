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

using System.IO.Ports;

namespace Ost.PicoOsci.Ui.Oscilloscope.Uart {
    public class ComPort : SerialPortIfc {
        public ComPort(string comPort) {
            m_serialPort = new SerialPort(comPort, 115200, Parity.Even, 8, StopBits.One);
        }

        /// <inheritdoc />
        public int BytesToRead => m_serialPort.BytesToRead;

        /// <inheritdoc />
        public int ReceivedBytesThreshold {
            get => m_serialPort.ReceivedBytesThreshold;
            set => m_serialPort.ReceivedBytesThreshold = value;
        }

        /// <inheritdoc />
        public bool IsOpen => m_serialPort.IsOpen;

        /// <inheritdoc />
        public event SerialDataReceivedEventHandler DataReceived {
            add => m_serialPort.DataReceived += value;
            remove => m_serialPort.DataReceived -= value;
        }

        /// <inheritdoc />
        public void Write(byte[] data, int offset, int length) {
            m_serialPort.Write(data, offset, length);
        }

        /// <inheritdoc />
        public int Read(byte[] data, int offset, int length) {
            return m_serialPort.Read(data, offset, length);
        }

        /// <inheritdoc />
        public int ReadByte() {
            return m_serialPort.ReadByte();
        }

        private SerialPort m_serialPort;
    }
}
