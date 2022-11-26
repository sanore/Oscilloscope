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

using System.ComponentModel;

namespace Ost.PicoOsci.Ui.Core.WPF {
    /// <summary>
    /// Interface for any observable object.
    /// </summary>
    public interface ObservableObjectIfc {
        /// <inheritdoc cref="INotifyPropertyChanged.PropertyChanged" />
        /// <summary>
        /// </summary>
        event PropertyChangedEventHandler PropertyChanged;

        /// <summary>
        /// register a property changed handler on this observable object ensuring it is registered only once
        /// with the uniqueHandlerId.
        /// </summary>
        /// <param name="uniqueHandlerId">a unique name, for which only one instance should be registered</param>
        /// <param name="handler">the PropertyChangedEventHandler delegate implementation</param>
        /// <returns>true if the handler has been registered, false if a handler with the uniqueHandlerId is already present</returns>
        bool RegisterPropertyChangeHandler(string uniqueHandlerId, PropertyChangedEventHandler handler);
    }
}
