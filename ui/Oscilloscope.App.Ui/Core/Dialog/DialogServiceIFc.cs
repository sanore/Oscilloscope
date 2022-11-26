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

namespace Ost.PicoOsci.Ui.Core.Dialog {
    /// <summary>
    /// Dialog service to open user dialogs.
    /// </summary>
    public interface DialogServiceIfc {
        /// <summary>
        /// Opens a file dialog with given parameters
        /// </summary>
        /// <returns>true if ok, otherwise false</returns>
        FileDialogResult OpenFileDialog(FileDialogParameter parameter);
    }

    /// <summary>
    /// A struct for dialog parameter
    /// </summary>
    public struct FileDialogParameter {
        /// <summary>
        /// Sets the dialog filter
        /// </summary>
        public string Filter { get; set; }

        /// <summary>
        /// Sets the default extension
        /// </summary>
        public string DefaultExt { get; set; }

        /// <summary>
        /// Sets the initial directory
        /// </summary>
        public string InitialDirectory { get; set; }
    }

    /// <summary>
    /// Represents a file dialog result
    /// </summary>
    public struct FileDialogResult {
        /// <summary>
        /// The selected file path. Can be null, when user abort dialog
        /// </summary>
        public string FileName { get; set; }

        /// <summary>
        /// The selected dialog result. True: user pressed ok, otherwise false.
        /// </summary>
        public bool? Result { get; set; }
    }
}
