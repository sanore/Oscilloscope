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

using System.Diagnostics;
using System.Diagnostics.CodeAnalysis;
using System.Windows;
using DryIoc;
using Microsoft.AppCenter;
using Microsoft.AppCenter.Analytics;
using Microsoft.AppCenter.Crashes;
using Ost.PicoOsci.Ui.Core.Window;
using Ost.PicoOsci.Ui.Presentation;
using Syncfusion.Licensing;

namespace Ost.PicoOsci.Ui {
    /// <summary>
    /// Interaction logic for App.xaml
    /// </summary>
    [ExcludeFromCodeCoverage]
    public partial class App {
        protected override async void OnStartup(StartupEventArgs e) {
            base.OnStartup(e);

            // Syncfusion licence
            SyncfusionLicenseProvider.RegisterLicense("NTM5NzY5QDMxMzkyZTMzMmUzMEhrY2V4ZzhYcjJSVDhyTHRzRlVsa2NPRUdvcjYzOG91QURqdkJKbUNtcDg9");

            // https://appcenter.ms/users/sandro.pedrett-ost.ch/apps/Oscilloscope/
            AppCenter.Start("0c5ec483-5a91-4d6d-990f-13ac0e797da0", typeof(Analytics), typeof(Crashes));

            await Crashes.SetEnabledAsync(!Debugger.IsAttached);

            var registrator = new Container(rules => rules.WithDefaultReuse(Reuse.Singleton));

            Instantiation.InitializeNotifyWrapper();
            Instantiation.RegisterApplication(registrator);
            Instantiation.RegisterActions(registrator);

            var viewModel = registrator.Resolve<MainWindowViewModel>();
            MainWindow = WindowUtil.CreateWindow<MainWindow>(viewModel);

            MainWindow?.Show();
        }
    }
}
