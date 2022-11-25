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

using Microsoft.Win32;

namespace Oscilloscope.App.Ui.Core.Dialog {
    /// <summary>
    /// A windows 32 dialog implementation.
    /// </summary>
    public class Win32DialogService : DialogServiceIfc {
        /// <inheritdoc />
        public FileDialogResult OpenFileDialog(FileDialogParameter parameter) {
            OpenFileDialog openFileDialog = new OpenFileDialog();
            openFileDialog.CheckPathExists = true;
            openFileDialog.CheckFileExists = true;
            openFileDialog.DefaultExt = parameter.DefaultExt;
            openFileDialog.Filter = parameter.Filter;
            openFileDialog.InitialDirectory = parameter.InitialDirectory;
            openFileDialog.RestoreDirectory = true;

            var value = new FileDialogResult();
            value.Result = openFileDialog.ShowDialog();
            value.FileName = openFileDialog.FileName;

            return value;
        }
    }
}
