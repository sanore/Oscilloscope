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
using System.ComponentModel;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Input;
using Ost.PicoOsci.Ui.Core.WPF.Decorators;

namespace Ost.PicoOsci.Ui.Core.Actions {
    /// <summary>
    /// Base class for asynchronous commands.
    /// see Patterns for Asynchronous MVVM Applications: Commands by Stephen Cleary
    /// https://msdn.microsoft.com/en-us/magazine/dn630647.aspx
    /// </summary>
    public abstract class AnAsyncAction : ObservableObject, AnActionIfc {
        /// <inheritdoc cref="AnActionIfc.Id" />
        public string Id { get; }

        /// <summary>
        /// Gets the cancel command
        /// </summary>
        public CancelAsyncCommand CancelCommand => m_cancelCommand;

        /// <summary>
        /// Gets the cancel token for this async action.
        /// </summary>
        public CancellationToken CancelToken => m_cancelCommand.Token;

        /// <summary>
        /// Gets or sets the NotifyTaskCompletion. Can be used for UI notifications based on Task status.
        /// </summary>
        public NotifyTaskCompletion Execution {
            get => m_execution;
            private set {
                m_execution = value;
                OnPropertyChanged();
            }
        }

        /// <inheritdoc cref="ICommand.CanExecuteChanged" />
        /// <summary>
        /// Occurs when changes occur that affect whether or not the command should execute.
        /// </summary>
        public event EventHandler CanExecuteChanged {
            add => CommandManager.RequerySuggested += value;
            remove => CommandManager.RequerySuggested -= value;
        }

        /// <summary>
        /// Constructor.
        /// </summary>
        public AnAsyncAction(string id, bool useOverrideCursor = true) {
            Id = id;
            Execution = new NotifyTaskCompletion(Task.CompletedTask);

            m_useOverrideCursor = useOverrideCursor;
            m_cancelCommand = new CancelAsyncCommand();
        }

        /// <inheritdoc cref="ICommand.CanExecute" />
        /// <summary>
        /// Defines the method that determines whether the command can execute in its current state.
        /// 
        /// The implementation should be return as fast as possible!
        /// </summary>
        public bool CanExecute(object parameter) {
            AnAsyncActionEvent actionEvent = GetArgs(parameter);
            return (Execution == null || Execution.IsCompleted) && CanExecute(actionEvent);
        }

        /// <inheritdoc cref="ICommand.Execute" />
        /// <summary>
        /// Defines the method to be called when the command is invoked.
        /// </summary>
        /// <param name="parameter">Data used by the command. If the command does not require data to be passed, this object can be set to null.</param>
        public async void Execute(object parameter) {
            var savedCursor = Mouse.OverrideCursor;

            try {
                if (m_useOverrideCursor) {
                    Mouse.OverrideCursor = Cursors.Wait;
                }

                m_cancelCommand.NotifyCommandStarting();
                var args = GetArgs(parameter);
                if (CanExecute(args)) {
                    await ExecuteAsync(args);
                }

                m_cancelCommand.NotifyCommandFinished();
            }
            catch (TaskCanceledException) {
                OnCanceled();
            }
            finally {
                if (m_useOverrideCursor) {
                    Mouse.OverrideCursor = savedCursor;
                }

                RaiseCanExecuteChanged();
            }
        }

        /// <summary>
        /// Make sure you return this as quick as possible. It's called very often by WPF framework.
        /// </summary>
        /// <param name="args">The action arguments.</param>
        /// <returns>True if actionPerformed is available, otherwise false.</returns>
        protected abstract bool CanExecute(AnAsyncActionEvent args);

        /// <summary>
        /// Is fired if action is executing.
        /// </summary>
        /// <param name="args">The action arguments.</param>
        protected abstract Task Execute(AnAsyncActionEvent args);

        /// <summary>
        /// Is fired when action is canceled.
        /// </summary>
        protected virtual void OnCanceled() { }

        protected static void RaiseCanExecuteChanged() {
            CommandManager.InvalidateRequerySuggested();
        }

        /// <summary>
        /// Defines the async method which is called when the command is invoked.
        /// </summary>
        /// <param name="parameter">Data used by the command. If the command does not require data to be passed, this object can be set to null.</param>
        private async Task ExecuteAsync(AnAsyncActionEvent parameter) {
            Execution = new NotifyTaskCompletion(Execute(parameter));
            RaiseCanExecuteChanged();
            await Execution.TaskCompletion;
        }

        private AnAsyncActionEvent GetArgs(object parameter) {
            switch (parameter) {
                case AnAsyncActionEvent asyncEventArgs:
                    return asyncEventArgs;
                case AnActionEvent eventArgs:
                    return new AnAsyncActionEvent(eventArgs.GetParameter<object>(), m_cancelCommand.Token);
            }

            return new AnAsyncActionEvent(parameter, m_cancelCommand.Token);
        }

        /// <summary>
        /// The Cancel Async command implementation to cancel an async command.
        /// </summary>
        public sealed class CancelAsyncCommand : DisposableObject, ICommand {
            /// <summary>
            /// Cancellation token to cancel the task.
            /// </summary>
            public CancellationToken Token => m_cancellationTokenSource.Token;

            /// <inheritdoc cref="ICommand.CanExecuteChanged" />
            public event EventHandler CanExecuteChanged {
                add => CommandManager.RequerySuggested += value;
                remove => CommandManager.RequerySuggested -= value;
            }

            /// <inheritdoc cref="ICommand.CanExecute" />
            /// <summary>
            /// </summary>
            public bool CanExecute(object parameter) {
                return m_commandExecuting && !m_cancellationTokenSource.IsCancellationRequested;
            }

            /// <inheritdoc cref="ICommand.Execute" />
            /// <summary>
            /// </summary>
            public void Execute(object parameter) {
                Cancel();
            }

            /// <summary>
            /// Requests a cancellation for given token.
            /// </summary>
            public void Cancel() {
                m_cancellationTokenSource.Cancel();
                RaiseCanExecuteChanged();
            }

            /// <summary>
            /// Notify the task is started
            /// </summary>
            public void NotifyCommandStarting() {
                m_commandExecuting = true;
                if (!m_cancellationTokenSource.IsCancellationRequested) {
                    return;
                }

                m_cancellationTokenSource = new CancellationTokenSource();
                RaiseCanExecuteChanged();
            }

            /// <summary>
            /// Notify the task is finished.
            /// </summary>
            public void NotifyCommandFinished() {
                m_commandExecuting = false;
                RaiseCanExecuteChanged();
            }

            protected override void DisposeManaged() {
                base.DisposeManaged();
                m_cancellationTokenSource?.Dispose();
            }

            private CancellationTokenSource m_cancellationTokenSource = new CancellationTokenSource();
            private bool m_commandExecuting;
        }

        /// <summary>
        /// Class to notify when asynchronous task is completed.
        /// see Patterns for Asynchronous MVVM Applications: Commands by Stephen Cleary
        /// https://msdn.microsoft.com/en-us/magazine/dn630647.aspx
        /// </summary>
        public sealed class NotifyTaskCompletion : INotifyPropertyChanged {
            /// <summary>
            /// The working Task itself.
            /// </summary>
            public Task Task { get; }

            /// <summary>
            /// Represents the completion task which has to be notified.
            /// </summary>
            public Task TaskCompletion { get; }

            /// <summary>
            /// Represents the current stage in the lifecycle of a Task.
            /// https://msdn.microsoft.com/en-us/library/system.threading.tasks.taskstatus(v=vs.110).aspx
            /// </summary>
            public TaskStatus Status => Task.Status;

            /// <summary>
            /// Returns true if task is completed.
            /// </summary>
            public bool IsCompleted => Task.IsCompleted;

            /// <summary>
            /// Returns true if task completed.
            /// </summary>
            public bool IsSuccessfullyCompleted => Task.Status == TaskStatus.RanToCompletion;

            /// <summary>
            /// Returns true if task is canceled.
            /// </summary>
            public bool IsCanceled => Task.IsCanceled;

            /// <summary>
            /// Returns true if task has fault.
            /// <see cref="Exception" />
            /// </summary>
            public bool IsFaulted => Task.IsFaulted;

            /// <summary>
            /// Returns the exception if there is one. otherwise null.
            /// </summary>
            public AggregateException Exception => Task.Exception;

            /// <summary>
            /// The exception message if there is an exception. otherwise null.
            /// </summary>
            public string ErrorMessage => Exception?.InnerException?.Message;

            /// <inheritdoc cref="INotifyPropertyChanged.PropertyChanged" />
            /// <summary>
            /// </summary>
            public event PropertyChangedEventHandler PropertyChanged;

            /// <summary>
            /// Constructor.
            /// </summary>
            public NotifyTaskCompletion(Task task) {
                Task = task;
                TaskCompletion = WatchTaskAsync(task);
            }

            private async Task WatchTaskAsync(Task task) {
                try {
                    await task;
                }
                finally {
                    var propertyChanged = PropertyChanged;
                    if (propertyChanged != null) {
                        propertyChanged(this, new PropertyChangedEventArgs(nameof(Status)));
                        propertyChanged(this, new PropertyChangedEventArgs(nameof(IsCompleted)));
                        if (task.IsCanceled) {
                            propertyChanged(this, new PropertyChangedEventArgs(nameof(IsCanceled)));
                        }
                        else if (task.IsFaulted) {
                            propertyChanged(this, new PropertyChangedEventArgs(nameof(IsFaulted)));
                            propertyChanged(this, new PropertyChangedEventArgs(nameof(Exception)));
                            propertyChanged(this, new PropertyChangedEventArgs(nameof(ErrorMessage)));
                        }
                        else {
                            propertyChanged(this, new PropertyChangedEventArgs(nameof(IsSuccessfullyCompleted)));
                            propertyChanged(this, new PropertyChangedEventArgs("Result"));
                        }
                    }
                }
            }
        }

        private readonly bool m_useOverrideCursor;

        private readonly CancelAsyncCommand m_cancelCommand;
        private NotifyTaskCompletion m_execution;
    }
}
