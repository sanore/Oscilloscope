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
using System.Collections.Generic;
using AutoUpdaterDotNET;
using Microsoft.AppCenter.Crashes;

namespace Ost.PicoOsci.Ui.Core.Updater {
    /// <summary>
    /// Uses the AutoUpdater.NET update framework
    /// <see cref="https://github.com/ravibpatel/AutoUpdater.NET" />
    /// </summary>
    public class WebUpdater : UpdaterIfc {
        /// <summary>
        /// The URL to the manifest xml file
        /// </summary>
        private const string URL = "https://test.pbuw.ch/Oscilloscope/Manifest/manifest.xml";

        /// <summary>
        /// Constructor
        /// </summary>
        public WebUpdater() {
            AutoUpdater.CheckForUpdateEvent += AutoUpdaterOnCheckForUpdateEvent;
        }

        private void AutoUpdaterOnCheckForUpdateEvent(UpdateInfoEventArgs args) {
            if (args.Error != null) {
                Crashes.TrackError(args.Error, new Dictionary<string, string> {
                    {"AppCast", URL}
                });

                return;
            }

            if (args.IsUpdateAvailable) {
                m_callback(args);
            }
        }

        /// <inheritdoc />
        public void CheckForUpdate(UpdateAvailableDelegate callback) {
            m_callback = callback;

            AutoUpdater.Start(URL, typeof(Instantiation).Assembly);
        }

        /// <inheritdoc />
        public bool PerformUpdate(UpdateInfoEventArgs updateInfoValue) {
            try {
                return AutoUpdater.DownloadUpdate(updateInfoValue);
            }
            catch (Exception e) {
                Crashes.TrackError(e, new Dictionary<string, string> {
                    {"DownloadURL", updateInfoValue.DownloadURL},
                    {"CurrentVersion", updateInfoValue.InstalledVersion.ToString()},
                    {"NextVersion", updateInfoValue.CurrentVersion}
                });
            }

            return false;
        }

        private UpdateAvailableDelegate m_callback;
    }
}
