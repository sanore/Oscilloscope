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
using System.ComponentModel;
using System.Windows;
using Ost.PicoOsci.Ui.Core.WPF.MVVM;

namespace Ost.PicoOsci.Ui.Core.Window {
    /// <summary>
    /// An interface for window views. To control the view instance from viewmodel
    /// </summary>
    public interface WindowIfc : UserControlIfc {
        /// <summary>
        /// Sets the position of the window when first shown. Has no effects after window is shown.
        /// </summary>
        WindowStartupLocation WindowStartupLocation { get; set; }

        /// <summary>
        /// Avoid for closing window before async event is ready.
        /// https://github.com/MahApps/MahApps.Metro/issues/1523
        /// </summary>
        bool IsShutdown { get; set; }

        /// <summary>
        /// Event called when window is deactivated
        /// </summary>
        event EventHandler Deactivated;

        /// <summary>
        /// Event called when window is activated
        /// </summary>
        event EventHandler Activated;

        /// <summary>
        /// Event called when window is closed
        /// </summary>
        event EventHandler Closed;

        /// <summary>
        /// Event called when window is closing
        /// </summary>
        event CancelEventHandler Closing;

        /// <summary>
        /// Closes the window
        /// </summary>
        void Close();

        /// <summary>
        /// Show the window
        /// </summary>
        void Show();

        /// <summary>
        /// Sets the owner for this window.
        /// </summary>
        /// <param name="owner"></param>
        void SetOwner(object owner);

        /// <summary>
        /// Brings the window to foreground.
        /// </summary>
        void BringToFront();
    }
}
