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
using DryIoc;
using Ost.PicoOsci.Ui.Core.Actions;
using Ost.PicoOsci.Ui.Core.Dialog;
using Ost.PicoOsci.Ui.Core.Docking;
using Ost.PicoOsci.Ui.Core.FileSystem;
using Ost.PicoOsci.Ui.Core.Updater;
using Ost.PicoOsci.Ui.Core.WPF.Notify;
using Ost.PicoOsci.Ui.Oscilloscope;
using Ost.PicoOsci.Ui.Oscilloscope.Actions;
using Ost.PicoOsci.Ui.Presentation;
using Ost.PicoOsci.Ui.Presentation.RecordViewer;
using Ost.PicoOsci.Ui.Presentation.TriggerCfg;
using Ost.PicoOsci.Ui.Presentation.Update;
using Ost.PicoOsci.Ui.Presentation.Update.Action;

namespace Ost.PicoOsci.Ui {
    /// <summary>
    /// Entry Point Class for Instantiation or Registration of Concrete objects
    /// Factories or builders for each feature registered here
    /// </summary>
    [ExcludeFromCodeCoverage]
    public static class Instantiation {
        /// <summary>
        /// Setup Notify Wrapper
        /// </summary>
        public static void InitializeNotifyWrapper() {
            Notify.Configure(new NotifyFactory());
        }

        /// <summary>
        /// Setup all docking components
        /// </summary>
        /// <param name="registrator">The registrator</param>
        public static void RegisterApplication(IContainer registrator) {
            // Panels
            registrator.Register<RecordViewerPanelViewModel>();
            registrator.Register<TriggerCfgPanelViewModel>();
            registrator.Register<PanelFactoryIfc<RecordViewerPanelViewModel>, PanelFactory.Panel<RecordViewerPanelViewModel>>();
            registrator.Register<PanelFactoryIfc<TriggerCfgPanelViewModel>, PanelFactory.Panel<TriggerCfgPanelViewModel>>();
            registrator.Register<DockingManagerIfc, DockingManager>();

            // Oscilloscope
            registrator.Register<OscilloscopeMgntIfc, OscilloscopeMgnt>();

            // Shell
            registrator.Register<MainWindowViewModel>();
            registrator.Register<ActionManagerIfc, ActionManager>();
            registrator.Register<DialogServiceIfc, Win32DialogService>();
            registrator.Register<FileSystemIfc, WinFileSystem>();

            // Update
            registrator.Register<UpdateWindowViewModel>();
            registrator.Register<UpdaterIfc, WebUpdater>();
        }

        /// <summary>
        /// Setup all actions
        /// </summary>
        /// <param name="registrator">The registrator</param>
        public static void RegisterActions(IContainer registrator) {
            registrator.Register<AnActionIfc, StartRecordAction>();
            registrator.Register<AnActionIfc, CheckForUpdateAction>();
        }
    }
}
