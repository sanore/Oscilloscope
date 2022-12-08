> **ACHTUNG**:
>
> Dieses Projekt wurde im Rahmen der Vorlesung DigMe 2022 bei Prof. Paul Zbinden umgesetzt. Der zeitliche Limitierungsfaktor von 24h zeigt sich im Code und 
> es wird daher nicht empfohlen, diesen weiter zu verwenden. Dennoch lässt sich das Ergebnis zeigen und kann für weitere Studenten eine Inspirazion sein.
>


# Oscilloscope
Eine sehr einfache implementation für das ZedBoard Zynq7000, welches ein Remote Oscilloscope implementiert. Das Oscilloscope kann über eine C# Applikation 
gesteuert werden. Folgende Features werden unterstützt:
- Mode: Edge Detection
  - Falling
  - Rising
  - Both

## Übersicht
![Overview](https://user-images.githubusercontent.com/4846634/206408973-857f767a-6d9b-4bb3-91bd-c4cee2741aa4.png)

* **PC**: Eine c# Applikation mit VS2022, welche die Charts und Konfigurationen darstellt. Siehe `./ui` Ordner für detailierte Implementation.
* **ARM**: Firmware auf Cortex A9 mit Vitis 2021.1, welche die Kommunikation zwischen PL und PC übernimmt. Siehe `./oscilloscope_app` für detailierte Implementation.
* **FPGA**: Hardware implementation mit Vivado 2021.1, welche die Logic für Trigger und einen Channel implementiert.

## Demo
https://user-images.githubusercontent.com/4846634/206411961-57b381e3-a8a5-4b37-a31a-f0edecebb67c.mp4

