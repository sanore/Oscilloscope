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

using System.Linq;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using NSubstitute;
using Ost.PicoOsci.Ui.Oscilloscope;
using Ost.PicoOsci.Ui.Oscilloscope.Uart;

namespace Ost.PicoOsci.Test.Oscilloscope.Uart {
    [TestClass]
    public class UartConnectionTest {
        [TestInitialize]
        public void Init() {
            m_listener   = Substitute.For<UartReceiverIfc>();
            m_serialPort = Substitute.For<SerialPortIfc>();

            m_testObject = new UartConnection(m_listener, _ => m_serialPort);
            m_testObject.Start("");
        }

        [TestMethod]
        public void StartAcquisition() {
            m_testObject.StartAcquire();

            var expectedSent = new byte[] { 0x1, 0x0 };
            AssertSent(expectedSent);
        }

        [TestMethod]
        public void SetTrigger() {
            TriggerConfig config = new TriggerConfig();
            config.Threshold.Value = 0.5;
            config.EdgeMode.Value = EdgeMode.Both;
            config.TriggerMode.Value = TriggerMode.Edge;

            m_testObject.SetTrigger(config);
            var expectedSent = new byte[] { 0x8, 0x6, 0x07, 0xff, 0b0011, 0b0000 };
            AssertSent(expectedSent);
        }

        private void AssertSent(byte[] expected) {
            m_serialPort.Received(1)
                        .Write(Arg.Is<byte[]>(res => expected.SequenceEqual(res)), 0, expected.Length);
        }

        private UartConnection  m_testObject;
        private UartReceiverIfc m_listener;
        private SerialPortIfc   m_serialPort;
    }
}
