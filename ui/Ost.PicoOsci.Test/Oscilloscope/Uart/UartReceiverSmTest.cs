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

using Microsoft.VisualStudio.TestTools.UnitTesting;
using NSubstitute;
using Ost.PicoOsci.Ui.Oscilloscope.Uart;

namespace Ost.PicoOsci.Test.Oscilloscope.Uart {
    [TestClass]
    public class UartReceiverSmTest {
        [TestInitialize]
        public void Init() {
            m_listener = Substitute.For<UartReceiverIfc>();
            m_testObject = new UartReceiverSm(m_listener);
        }

        [TestMethod]
        public void TestStartTag() {
            m_testObject.Process(0b10000010); // Tag=Acquire
            m_testObject.Process(0b00000011); // Length=3

            m_listener.Received(1)
                      .OnAcquireStarted();
            m_listener.DidNotReceive()
                      .OnAcquireCompleted(Arg.Any<byte[]>(), Arg.Any<int>());

            m_testObject.Process(1);
            m_testObject.Process(2);
            m_testObject.Process(3);

            m_listener.Received(1)
                      .OnAcquireCompleted(Arg.Any<byte[]>(), 3);
        }

        private UartReceiverSm m_testObject;
        private UartReceiverIfc m_listener;
    }
}
