// (c) IMT - Information Management Technology AG, CH-9470 Buchs, www.imt.ch.
// SW guideline: Technote Coding Guidelines Ver. 1.4

using System.IO.Ports;

namespace Ost.PicoOsci.Ui.Oscilloscope.Uart {
    /// <summary>
    /// Represent a interface for the .NET SerialPort. This interface is needed for mocking
    /// the serial port (COM)
    /// </summary>
    public interface SerialPortIfc {
        int BytesToRead { get; }
        int ReceivedBytesThreshold { get; set; }

        bool IsOpen { get; }

        void Open();
        void Write(byte[] data, int offset, int length);
        int Read(byte[] data, int offset, int length);
        int ReadByte();
        string ReadLine();

        event SerialDataReceivedEventHandler DataReceived;
    }
}