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
using System.Windows.Input;

namespace Ost.PicoOsci.Ui.Core.Actions {
    /// <summary>
    /// An action for given WPF command.
    /// </summary>
    public abstract class AnAction : AnActionIfc {
        /// <inheritdoc />
        public string Id { get; }

        /// <see cref="ICommand.CanExecuteChanged" />
        public event EventHandler CanExecuteChanged {
            add => CommandManager.RequerySuggested += value;
            remove => CommandManager.RequerySuggested -= value;
        }

        /// <summary>
        /// Constructor.
        /// </summary>
        /// <param name="id">The unique action id</param>
        protected AnAction(string id) {
            Id = id;
        }

        /// <see cref="ICommand.CanExecute" />
        public virtual bool CanExecute(object parameter) {
            AnActionEvent actionEvent = parameter as AnActionEvent ?? new AnActionEvent(parameter);
            return CanExecute(actionEvent);
        }

        /// <see cref="ICommand.Execute" />
        public void Execute(object parameter) {
            AnActionEvent actionEvent = parameter as AnActionEvent ?? new AnActionEvent(parameter);
            Execute(actionEvent);
        }

        /// <summary>
        /// Is fired if action is executing.
        /// </summary>
        /// <param name="args">The action arguments.</param>
        protected abstract void Execute(AnActionEvent args);

        /// <summary>
        /// Make sure you return this as quick as possible. It's called very often by WPF framework.
        /// </summary>
        /// <param name="args">The action arguments.</param>
        /// <returns>True if actionPerformed is available, otherwise false.</returns>
        protected abstract bool CanExecute(AnActionEvent args);
    }
}
