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
using System.Windows;
using Ost.PicoOsci.Ui.Core.WPF.Decorators;

namespace Ost.PicoOsci.Ui.Core.WPF.MVVM {
    /// <summary>
    /// A ViewModelBase with a type-safe framework element.
    /// </summary>
    /// <typeparam name="TView">Type of bound control</typeparam>
    public abstract class ViewModelBase<TView> : ViewModelBase where TView : UserControlIfc {
        /// <inheritdoc cref="System.Windows.Controls.Control" />
        /// <summary>
        /// A specified framework element type.
        /// </summary>
        public new TView Control {
            get => (TView) base.Control;
            set => base.Control = value;
        }
    }

    /// <summary>
    /// Abstract base class for view models.
    /// </summary>
    public abstract class ViewModelBase : ObservableObject, ViewModelIfc {
        /// <summary>
        /// Gets or sets the corresponding framework element.
        /// 
        /// Note:
        /// - This element is automatically set if control is binded by <see cref="UserControl.AutoBindingContextProperty" />
        /// - This is a violation of MVVM Framework. View model should not see view
        /// </summary>
        public UserControlIfc Control { get; set; }

        /// <summary>
        /// Executes initialization tasks after view loaded.
        /// </summary>
        public virtual void OnViewLoaded() { }

        /// <summary>
        /// Executes initialization tasks after content rendered.
        /// </summary>
        public virtual void OnContentRendered() { }

        /// <summary>
        /// Executes an update when an external change was performed.
        /// </summary>
        public virtual void OnUpdate() { }

        /// <summary>
        /// Runs the given action in a dispatcher context with ui access, if required
        /// in case the calling thread is not the UI thread, synchronously,
        /// i.e. WAITS for the action to be completed
        /// </summary>
        /// <param name="action">Action to execute in ui context.</param>
        public void Invoke(Action action) {
            if (Control is FrameworkElement fw
                && fw.Dispatcher != null && !fw.Dispatcher.CheckAccess()) {
                fw.Dispatcher.Invoke(action);
            }
            else {
                action();
            }
        }

        /// <summary>
        /// Runs the given action in a dispatcher context with ui access, if required
        /// in case the calling thread is not the UI thread, asynchronously,
        /// i.e. does NOT WAIT for the action to be completed
        /// </summary>
        /// <param name="action">Action to execute in ui context.</param>
        public void BeginInvoke(Action action) {
            if (Control is FrameworkElement fw
                && fw.Dispatcher != null && !fw.Dispatcher.CheckAccess()) {
                fw.Dispatcher?.BeginInvoke(action);
            }
            else {
                action();
            }
        }

        /// <inheritdoc cref="ObservableObject.DisposeManaged" />
        protected override void DisposeManaged() {
            Control = null;
            base.DisposeManaged();
        }
    }
}
