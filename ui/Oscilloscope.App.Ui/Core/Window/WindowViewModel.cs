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

using System.Threading.Tasks;
using Oscilloscope.App.Ui.Core.WPF.MVVM;

namespace Oscilloscope.App.Ui.Core.Window {
    /// <summary>
    /// Represents a interface between viewmodel and his window view. It controls the view and
    /// provides a default implementation for view events.
    /// <see cref="WindowIfc" />
    /// </summary>
    public class WindowViewModel : ViewModelBase<WindowIfc> {
        /// <summary>
        /// Is true if this window has no owner window.
        ///
        /// Note: A root window closes all child windows and is needed to center child windows based on root window location.
        /// </summary>
        public bool IsRootWindow { get; protected set; }

        public WindowViewModel() {
            IsRootWindow = false;
        }

        /// <summary>
        /// Sends a close request to attached window view.
        /// </summary>
        public void Close() {
            Invoke(() => { Control?.Close(); });
        }

        /// <summary>
        /// Invokes if focus received.
        /// </summary>
        public virtual void OnActivatedHandler() { }

        /// <inheritdoc cref="ViewModelBase.OnContentRendered" />
        public override void OnContentRendered() {
            base.OnContentRendered();

            Invoke(() => { Control?.BringToFront(); });
        }

        /// <summary>
        /// Invoke if focus lost.
        /// </summary>
        public virtual void OnDeactivatedHandler() { }

        /// <summary>
        /// Invoks after a close request received.
        /// </summary>
        /// <returns>True if window can be closed, otherwise false.</returns>
        public virtual Task<bool> OnClosingHandler() {
            return Task.FromResult(true);
        }

        /// <summary>
        /// Invokes after the closing event to canceled.
        /// </summary>
        public virtual void OnClosedHandler() { }
    }
}
