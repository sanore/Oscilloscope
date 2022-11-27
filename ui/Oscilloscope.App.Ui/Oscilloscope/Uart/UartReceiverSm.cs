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

namespace Ost.PicoOsci.Ui.Oscilloscope.Uart {
    public class UartReceiverSm {
        public UartReceiverSm(UartReceiverIfc listener) {
            m_listener = listener;
            m_state    = State.HeaderParse;
            m_buffer   = new List<byte>();
        }

        public void Process(byte value) {
            switch (m_state) {
            case State.HeaderParse:
                ParseHeader(value);
                break;
            case State.DataParse:
                ParseData(value);
                break;
            default:
                throw new ArgumentOutOfRangeException();
            }
        }

        private void ParseHeader(byte data) {
            switch (m_counter) {
            case 0: {
                var toPc = (data & 0x80) != 0;
                if (!toPc) { return; }

                m_counter++;
                m_lastTag = (UartConnection.Tag)(data & 0x0F);
                break;
            }

            case 1: {
                m_lastLength = data;

                switch (m_lastTag) {
                case UartConnection.Tag.Acquire:
                    m_buffer.Clear();
                    m_listener.OnAcquireStarted();
                    m_state = State.DataParse;
                    break;
                }

                m_counter = 0;

                break;
            }
            }
        }

        private void ParseData(byte value) {
            m_buffer.Add(value);

            if (m_buffer.Count == m_lastLength) {
                m_listener.OnAcquireCompleted(m_buffer.ToArray(), m_lastLength);
                m_state = State.HeaderParse;
            }
        }

        private readonly UartReceiverIfc    m_listener;
        private readonly List<byte>         m_buffer;
        private          State              m_state;
        private          int                m_counter;
        private          UartConnection.Tag m_lastTag;
        private          int                m_lastLength;

        private enum State {
            HeaderParse,
            DataParse
        }
    }
}
