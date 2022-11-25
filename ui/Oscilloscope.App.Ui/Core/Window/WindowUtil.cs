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
using System.Diagnostics.CodeAnalysis;
using System.Threading.Tasks;
using System.Windows;
using Oscilloscope.App.Ui.Core.WPF;

namespace Oscilloscope.App.Ui.Core.Window {
    /// <summary>
    /// Helper class for window system.
    /// </summary>
    [ExcludeFromCodeCoverage]
    public static class WindowUtil {
        /// <summary>
        /// Creates and bind a new window to given viewmodel.
        /// </summary>
        /// <typeparam name="TView">expected window</typeparam>
        /// <param name="viewModel">viewmodel to bind</param>
        /// <returns>the window which is created.</returns>
        public static TView CreateWindow<TView>(WindowViewModel viewModel) where TView : WindowIfc, new() {
            TView window = new TView {
                AutoBindingContext = viewModel
            };

            // set owner for this window.
            if (!viewModel.IsRootWindow) {
                System.Windows.Window ownerWindow = WpfHelper.FindOwnerOf(window);
                if (ownerWindow != null) {
                    window.SetOwner(ownerWindow);
                    window.WindowStartupLocation = WindowStartupLocation.CenterOwner;
                }
            }

            window.Activated += WindowOnActivated;
            window.Deactivated += WindowOnDeactivated;
            window.Closing += WindowOnClosing;
            window.Closed += WindowOnClosed;

            return window;
        }

        private static void WindowOnClosed(object sender, EventArgs e) {
            WindowIfc window = (WindowIfc) sender;
            WindowViewModel viewModel = (WindowViewModel) window.AutoBindingContext;
            viewModel.OnClosedHandler();

            DisposeWindow(window);
        }

        private static async void WindowOnClosing(object sender, CancelEventArgs e) {
            WindowIfc window = (WindowIfc) sender;
            WindowViewModel viewModel = (WindowViewModel) window.AutoBindingContext;

            // avoid closing window before async event handler are ready.
            // https://github.com/MahApps/MahApps.Metro/issues/1523
            e.Cancel = !window.IsShutdown;
            if (window.IsShutdown) {
                return;
            }

            // Makes sure e.Cancel is applyed to WindowInteropHandler. If OnClosingHandler returns directly a result, the
            // Window is still in closing mode and window.Close() throws following exception:
            //      "Cannot set Visibility to Visible or call Show, ShowDialog, Close, or WindowInteropHelper.EnsureHandle while a Window is closing."
            // To avoid this exception we leave this context by a starting a short delay and code is continue on parent context.
            // So the e.cancel is applyed and closing mode is leaved. After that we can continue with our code.
            await Task.Delay(1);

            bool shouldClose = await viewModel.OnClosingHandler();

            if (shouldClose) {
                window.IsShutdown = true;
                window.Close();
            }
        }

        private static void WindowOnDeactivated(object sender, EventArgs e) {
            WindowIfc window = (WindowIfc) sender;
            WindowViewModel viewModel = (WindowViewModel) window.AutoBindingContext;
            viewModel.OnDeactivatedHandler();
        }

        private static void WindowOnActivated(object sender, EventArgs e) {
            WindowIfc window = (WindowIfc) sender;
            WindowViewModel viewModel = (WindowViewModel) window.AutoBindingContext;
            viewModel.OnActivatedHandler();
        }

        /// <summary>
        /// Dispose a window and detach all events.
        /// </summary>
        /// <param name="window"></param>
        private static void DisposeWindow(WindowIfc window) {
            window.Activated -= WindowOnActivated;
            window.Deactivated -= WindowOnDeactivated;
            window.Closing -= WindowOnClosing;
            window.Closed -= WindowOnClosed;

            WindowViewModel viewModel = (WindowViewModel) window.AutoBindingContext;

            window.AutoBindingContext = null;

            viewModel.Dispose();
        }
    }
}
