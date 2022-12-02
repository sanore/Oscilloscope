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

namespace Ost.PicoOsci.Ui.Oscilloscope.Uart {
    public class UartReceiverSm {
        public UartReceiverSm(UartReceiverIfc listener) {
            m_listener = listener;
            m_state    = State.HeaderTagParse;
            m_dataBuffer   = new List<byte>();
        }

        public void Process(byte data) {
            switch (m_state) {
            case State.HeaderTagParse: {
                    var toPc = (data & 0x80) != 0;
                    if (!toPc) { return; }

                    m_lastTag = (UartConnection.Tag)(data & 0x0F);
                    m_state = State.HeaderInfoParse;
                    m_dataBuffer.Clear();
                    break;
                }

            case State.HeaderInfoParse: {
                    m_headerLength--;

                    if (m_headerLength < 0) {
                        m_headerLength = data;
                    } else {
                        m_dataBuffer.Add(data);
                    }

                    if (m_headerLength == 0) {
                        var buffer = m_dataBuffer.ToArray();
                        m_dataBuffer.Clear();

                        m_lastTriggerIdx = buffer[2] << 8 | buffer[3];
                        m_lastDataLength = buffer[0] << 8 | buffer[1];

                        if (m_lastTag == UartConnection.Tag.Acquire) {
                            m_state = State.DataParse;
                            m_listener.OnAcquireStarted();
                        }
                        else {
                            m_state = State.HeaderTagParse;
                        }
                    }

                    break;
                }

            case State.DataParse:
                ParseData(data);
                break;
            default:
                throw new ArgumentOutOfRangeException();
            }
        }

        private void ParseData(byte value) {
            m_dataBuffer.Add(value);

            if (m_lastDataLength == m_dataBuffer.Count) {
                m_listener.OnAcquireCompleted(m_lastTriggerIdx, m_dataBuffer);
                m_state = State.HeaderTagParse;
            }
        }

        private readonly UartReceiverIfc    m_listener;
        private readonly List<byte>         m_dataBuffer;
        private          State              m_state;
        private          UartConnection.Tag m_lastTag;
        private          int                m_lastTriggerIdx;
        private          int                m_lastDataLength;
        private          int                m_headerLength;

        private enum State {
            HeaderTagParse,
            HeaderInfoParse,
            DataParse
        }
    }
}
