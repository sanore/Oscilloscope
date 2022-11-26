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
using System.Diagnostics.CodeAnalysis;
using System.IO;
using System.Net;
using AutoUpdaterDotNET;
using Ost.PicoOsci.Ui.Core.Actions;
using Ost.PicoOsci.Ui.Core.Updater;
using Ost.PicoOsci.Ui.Core.Window;
using Ost.PicoOsci.Ui.Core.WPF.Notify;

namespace Ost.PicoOsci.Ui.Presentation.Update {
    /// <summary>
    /// A update window viewmodel
    /// </summary>
    [ExcludeFromCodeCoverage]
    public class UpdateWindowViewModel : WindowViewModel {
        /// <summary>
        /// Gets the update info.
        /// </summary>
        public NotifyRefIfc<UpdateInfoEventArgs> UpdateInfo { get; }

        /// <summary>
        /// Starts the update
        /// </summary>
        public AnActionIfc UpdateCommand { get; }

        /// <summary>
        /// Starts the update
        /// </summary>
        public NotifyStringIfc Changelog { get; }

        /// <summary>
        /// Gets the cancel command
        /// </summary>
        public AnActionIfc CancelCommand { get; }

        /// <summary>
        /// Constructor
        /// </summary>
        public UpdateWindowViewModel(UpdaterIfc updater) {
            m_updater  = updater;
            UpdateInfo = Notify.MakeRef(new UpdateInfoEventArgs());
            Changelog  = new NotifyString("Loading changelog...");

            UpdateCommand = new AnActionDelegate(OnPerformUpdate);
            CancelCommand = new AnActionDelegate(_ => Close());
        }

        /// <inheritdoc />
        public override void OnViewLoaded() {
            base.OnViewLoaded();

            DownloadChangelog();
        }

        private async void DownloadChangelog() {
            if (string.IsNullOrWhiteSpace(UpdateInfo.Value.ChangelogURL)) {
                Changelog.Value = "No changelog available";

                return;
            }

            try {
                using (var client = new WebClient()) {
                    var stream = await client.OpenReadTaskAsync(UpdateInfo.Value.ChangelogURL);
                    using (var reader = new StreamReader(stream)) { Changelog.Value = await reader.ReadToEndAsync(); }
                }
            }
            catch { Changelog.Value = $"Error. Please visit '{UpdateInfo.Value.ChangelogURL}'"; }
        }

        private void OnPerformUpdate(AnActionEvent obj) {
            var result = m_updater.PerformUpdate(UpdateInfo.Value);

            if (result) { Environment.Exit(0); }
        }

        private readonly UpdaterIfc m_updater;
    }
}
