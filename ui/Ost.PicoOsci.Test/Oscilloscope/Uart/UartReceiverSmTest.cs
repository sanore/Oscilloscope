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
using System.Collections.Generic;

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
            m_testObject.Process(0b00000100); // Length=4
            m_testObject.Process(0b00000000); // 0
            m_testObject.Process(0b00000001); // DataLength
            m_testObject.Process(0b00000000); // 0
            m_testObject.Process(0b00000011); // TriggerIndex

            m_listener.Received(1)
                      .OnAcquireStarted();
            m_listener.DidNotReceive()
                      .OnAcquireCompleted(Arg.Any<int>(), Arg.Any<List<byte>>());

            m_testObject.Process(0b11111111); // 255

            m_listener.Received(1)
                      .OnAcquireCompleted(3, Arg.Any<List<byte>>());
        }

        private UartReceiverSm m_testObject;
        private UartReceiverIfc m_listener;
    }
}
