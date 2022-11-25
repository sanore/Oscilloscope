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

using System.Collections;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;

namespace Oscilloscope.App.Ui.Connection {
    public class Record : IEnumerable<Record.TimePoint> {
        /// <summary>
        /// Gets a list of values
        /// </summary>
        public IEnumerable<TimePoint> Values => m_values;

        /// <summary>
        /// Gets the binding name for X axis
        /// </summary>
        public string BindingX => nameof(TimePoint.Time);

        /// <summary>
        /// Gets the binding name for Y axis
        /// </summary>
        public string BindingY => nameof(TimePoint.Value);

        /// <summary>
        /// Gets the maximum time
        /// </summary>
        public double MaxTime => Values.Select(x => x.Time)
                                       .Max();

        /// <summary>
        /// Gets the minimum time
        /// </summary>
        public double MinTime => Values.Select(x => x.Time)
                                       .Min();

        /// <summary>
        /// Gets the maximum value
        /// </summary>
        public double MaxValue => Values.Select(x => x.Value)
                                        .Max();

        /// <summary>
        /// Gets the minimum value
        /// </summary>
        public double MinValue => Values.Select(x => x.Value)
                                        .Min();

        /// <summary>
        /// Constructor.
        /// </summary>
        public Record() {
            m_values = new ObservableCollection<TimePoint>();
        }

        /// <inheritdoc />
        public IEnumerator<TimePoint> GetEnumerator() {
            return m_values.GetEnumerator();
        }

        /// <inheritdoc />
        IEnumerator IEnumerable.GetEnumerator() {
            return ((IEnumerable)m_values).GetEnumerator();
        }

        /// <summary>
        /// Adds a new time point.
        /// </summary>
        /// <param name="time">The time</param>
        /// <param name="value">The value</param>
        public void Add(double time, double value) {
            m_values.Add(new TimePoint(time, value));
        }

        private readonly IList<TimePoint> m_values;

        /// <summary>
        /// A time point which holds the value to given time.
        /// </summary>
        public struct TimePoint {
            /// <summary>
            /// Constructor
            /// </summary>
            /// <param name="time">The x-coordinate of the new structure. </param>
            /// <param name="value">The y-coordinate of the new structure. </param>
            public TimePoint(double time, double value) {
                Time = time;
                Value = value;
            }

            /// <summary>
            /// Gets or sets the time
            /// </summary>
            public double Time { get; set; }

            /// <summary>
            /// Gets or sets the value
            /// </summary>
            public double Value { get; set; }
        }
    }
}
