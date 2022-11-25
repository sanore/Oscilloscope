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

using System.Diagnostics.CodeAnalysis;
using AutoUpdaterDotNET;
using Oscilloscope.App.Ui.Core.Actions;
using Oscilloscope.App.Ui.Core.Updater;
using Oscilloscope.App.Ui.Core.Window;

namespace Oscilloscope.App.Ui.Presentation.Update.Action {
    /// <summary>
    /// Checks for new update and open dialog with detailed information when new update is available
    /// </summary>
    [ExcludeFromCodeCoverage]
    public class CheckForUpdateAction : AnAction {
        /// <summary>
        /// Unique action id
        /// </summary>
        public const string ID = "CheckForUpdate";

        /// <inheritdoc />
        public CheckForUpdateAction(UpdaterIfc updater, UpdateWindowViewModel updateVm) : base(ID) {
            m_updater = updater;
            m_updateVm = updateVm;
        }

        /// <inheritdoc />
        protected override void Execute(AnActionEvent args) {
            m_updater.CheckForUpdate(Callback);
        }

        private void Callback(UpdateInfoEventArgs args) {
            m_updateVm.UpdateInfo.Value = args;

            var updateWindow = WindowUtil.CreateWindow<UpdateWindow>(m_updateVm);
            updateWindow.ShowDialog();
        }

        /// <inheritdoc />
        protected override bool CanExecute(AnActionEvent args) {
            return true;
        }

        private readonly UpdaterIfc m_updater;
        private readonly UpdateWindowViewModel m_updateVm;
    }
}
