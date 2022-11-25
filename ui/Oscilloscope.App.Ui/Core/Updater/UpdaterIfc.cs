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

using AutoUpdaterDotNET;

namespace Oscilloscope.App.Ui.Core.Updater {
    /// <summary>
    /// Callback delegate for custom dialog
    /// </summary>
    /// <param name="args"></param>
    public delegate void UpdateAvailableDelegate(UpdateInfoEventArgs args);

    /// <summary>
    /// An updater interface to load and manage updates
    ///
    /// TODO Do not use AutoUpdate.NET UpdateInfoEventArgs specific file in interface!
    /// </summary>
    public interface UpdaterIfc {
        /// <summary>
        /// Check if update is available
        /// </summary>
        /// <param name="callback"></param>
        void CheckForUpdate(UpdateAvailableDelegate callback);

        /// <summary>
        /// Performs the given update
        /// </summary>
        /// <param name="updateInfoValue"></param>
        /// <returns></returns>
        bool PerformUpdate(UpdateInfoEventArgs updateInfoValue);
    }
}
