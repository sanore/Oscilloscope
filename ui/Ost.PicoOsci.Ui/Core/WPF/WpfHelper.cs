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
using System.Diagnostics;
using System.Diagnostics.CodeAnalysis;
using System.Linq;
using System.Runtime.InteropServices;
using System.Windows;
using System.Windows.Controls.Primitives;
using System.Windows.Interop;
using System.Windows.Media;

namespace Ost.PicoOsci.Ui.Core.WPF {
    /// <summary>
    /// Static WPF Helper class.
    /// </summary>
    [ExcludeFromCodeCoverage]
    public static class WpfHelper {
        /// <summary>
        /// Infers the owner of the window.
        /// </summary>
        /// <param name="window">The window to whose owner needs to be determined.</param>
        /// <returns>The owner.</returns>
        public static System.Windows.Window FindOwnerOf(object window) {
            var application = Application.Current;
            if (application?.MainWindow == null) {
                return null;
            }

            var activeWindow = application.Windows.OfType<System.Windows.Window>()
                                          .FirstOrDefault(x => x.IsActive);
            activeWindow = activeWindow ?? (PresentationSource.FromVisual(application.MainWindow) == null ? null : application.MainWindow);

            return Equals(activeWindow, window) ? null : activeWindow;
        }

        /// <summary>
        /// Gets the first focusable input element recursively.
        /// </summary>
        /// <param name="element"></param>
        /// <returns></returns>
        public static FrameworkElement GetFirstFocusableInputElement(FrameworkElement element) {
            if (element.Focusable) {
                return element;
            }

            foreach (FrameworkElement child in LogicalTreeHelper.GetChildren(element)) {
                // Recursive call
                var focusableElement = GetFirstFocusableInputElement(child);
                if (focusableElement.Focusable && (focusableElement is TextBoxBase || focusableElement is ButtonBase)) {
                    return focusableElement;
                }
            }

            return null;
        }

        /// <summary>
        /// Brings a WPF window to front.
        /// </summary>
        /// <param name="window"></param>
        public static void BringToFront(System.Windows.Window window) {
            IntPtr handle = new WindowInteropHelper(window).Handle;
            NativeMethods.SetForegroundWindow(handle);
        }

        /// <summary>
        /// Traverse to top until first expected type is detected.
        /// </summary>
        /// <param name="startObject">Start object where search is starting.</param>
        /// <typeparam name="T">Expected type</typeparam>
        /// <returns>The expected dependency object or null if nothing found.</returns>
        public static T GetDependencyObjectFromVisualTree<T>(DependencyObject startObject) where T : DependencyObject {
            var type = typeof(T);
            var parent = startObject;

            while (parent != null) {
                if (type.IsInstanceOfType(parent)) {
                    return parent as T;
                }

                parent = VisualTreeHelper.GetParent(parent);
            }

            return null;
        }

        /// <summary>
        /// Search for an element of a certain type in the visual tree.
        /// </summary>
        /// <typeparam name="T">The type of element to find.</typeparam>
        /// <param name="visual">The parent element.</param>
        /// <returns></returns>
        public static T FindVisualChild<T>(Visual visual) where T : Visual {
            for (int i = 0; i < VisualTreeHelper.GetChildrenCount(visual); i++) {
                Visual child = (Visual) VisualTreeHelper.GetChild(visual, i);
                if (child != null) {
                    T correctlyTyped = child as T;
                    if (correctlyTyped != null) {
                        return correctlyTyped;
                    }

                    T descendent = FindVisualChild<T>(child);
                    if (descendent != null) {
                        return descendent;
                    }

                    // also search recursive
                    descendent = FindVisualChild<T>(child);
                    if (descendent != null) {
                        return descendent;
                    }
                }
            }

            return null;
        }

        /// <summary>
        /// Search for an element of a certain type in the visual tree.
        /// </summary>
        /// <typeparam name="T">The type of element to find.</typeparam>
        /// <param name="visual">The parent element.</param>
        /// <returns></returns>
        private static T FindVisualChild<T>(DependencyObject parent) where T : DependencyObject {
            for (int childCount = 0; childCount < VisualTreeHelper.GetChildrenCount(parent); childCount++) {
                DependencyObject child = VisualTreeHelper.GetChild(parent, childCount);
                if (child != null && child is T) {
                    return (T) child;
                }
                else {
                    T childOfChild = FindVisualChild<T>(child);
                    if (childOfChild != null) {
                        return childOfChild;
                    }
                }
            }

            return null;
        }

        /// <summary>
        /// Gets the window handle of the current application.
        /// </summary>
        /// <returns></returns>
        private static IntPtr GetCurrentInstanceWindowHandle() {
            IntPtr hWnd = IntPtr.Zero;
            Process currentProcess = Process.GetCurrentProcess();
            Process[] processes = Process.GetProcessesByName(currentProcess.ProcessName);
            foreach (Process process in processes) {
                // Get the first instance that is not this instance, has the same process name and was started from the same file name
                // and location. Also check that the process has a valid window handle in this session to filter out other user's processes.
                if (process.Id != currentProcess.Id
                    && process.MainModule.FileName == currentProcess.MainModule.FileName
                    && process.MainWindowHandle != IntPtr.Zero) {
                    hWnd = process.MainWindowHandle;
                    break;
                }
            }

            return hWnd;
        }

        private static class NativeMethods {
            [DllImport("user32.dll")]
            public static extern int ShowWindow(IntPtr hWnd, int nCmdShow);

            [DllImport("user32.dll")]
            public static extern int SetForegroundWindow(IntPtr hWnd);

            [DllImport("user32.dll")]
            public static extern int IsIconic(IntPtr hWnd);
        }
    }
}
