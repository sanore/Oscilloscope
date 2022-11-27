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

namespace Ost.PicoOsci.Ui.Core.Actions {
    /// <summary>
    /// A manager for actions. Used to register actions, also
    /// contains utility methods to easily fetch action by id.
    /// <see cref="AnActionIfc" />
    /// </summary>
    public interface ActionManagerIfc {
        /// <summary>
        /// Registers the specified action.
        /// </summary>
        /// <param name="action">Action to register</param>
        void RegisterAction(AnActionIfc action);

        /// <summary>
        /// Get the action which is associated with the given id.
        /// </summary>
        /// <param name="actionId">Id to associate with the action</param>
        /// <returns>The action or null if no action with id is registered.</returns>
        AnActionIfc GetAction(string actionId);
    }
}
