// MIT License
// 
// Copyright (c) 2021 Oscilloscope
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
using System.Collections.Concurrent;
using System.Collections.Generic;

namespace Ost.PicoOsci.Ui.Core.Actions {
    /// <inheritdoc cref="ActionManagerIfc" />
    public class ActionManager : ActionManagerIfc {
        /// <summary>
        /// A list of all registered actions which are available for this manager.
        /// </summary>
        public IEnumerable<AnActionIfc> Actions => m_id2Action.Values;

        /// <summary>
        /// Constructor.
        /// </summary>
        public ActionManager(IList<AnActionIfc> actions) {
            m_id2Action = new ConcurrentDictionary<string, AnActionIfc>();

            foreach (var action in actions) {
                RegisterAction(action);
            }
        }

        /// <inheritdoc cref="ActionManagerIfc.RegisterAction" />
        /// <summary>
        /// Can not register action if ID is already registered.
        /// </summary>
        public void RegisterAction(AnActionIfc action) {
            if (m_id2Action.ContainsKey(action.Id)) {
                throw new ArgumentOutOfRangeException($"Action was already registered for another ID. Id is {action.Id}");
            }

            m_id2Action.Add(action.Id, action);
        }

        /// <inheritdoc cref="ActionManagerIfc.GetAction" />
        public AnActionIfc GetAction(string actionId) {
            if (string.IsNullOrWhiteSpace(actionId)) {
                return null;
            }

            return m_id2Action.ContainsKey(actionId) ? m_id2Action[actionId] : null;
        }

        private readonly IDictionary<string, AnActionIfc> m_id2Action;
    }
}
