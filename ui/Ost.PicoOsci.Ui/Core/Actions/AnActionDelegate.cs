// MIT License
// 
// Copyright (c) 2021 LinearSPICE
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

namespace Ost.PicoOsci.Ui.Core.Actions {
    /// <summary>
    /// An action which uses delegates
    /// </summary>
    public class AnActionDelegate : AnAction {
        /// <summary>
        /// Constructor. Creates a new command.
        /// </summary>
        /// <param name="execute">The execution logic.</param>
        /// <param name="canExecute">The execution status logic.</param>
        public AnActionDelegate(Action<AnActionEvent> execute, Predicate<AnActionEvent> canExecute = null) : base(null) {
            m_execute = execute;
            m_canExecute = canExecute;
        }

        /// <inheritdoc />
        protected sealed override void Execute(AnActionEvent args) {
            if (!CanExecute(args)) {
                return;
            }

            m_execute(args);
        }

        /// <inheritdoc />
        protected sealed override bool CanExecute(AnActionEvent args) {
            if (m_canExecute == null) {
                return true;
            }

            return m_canExecute(args);
        }

        private readonly Action<AnActionEvent> m_execute;
        private readonly Predicate<AnActionEvent> m_canExecute;
    }
}
