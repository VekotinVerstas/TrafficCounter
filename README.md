# TrafficCounterPi

TrafficCounterPi is a project to develop a sensor for traffic counting purposes. The sensor would use an existing inductive loops installed on road. The sensor runs on a Raspberry Pi 3 Model B using Jessie Lite. The sensing unit is based on Texas Instruments LDC1614 Inductance-to-Digital converter.

The sensor measurement data is stored on hourly dumps at /var/sensordata. The file is a SQLite database.

The sensor software is a native Linux binary built on Xojo IDE v2017r1.1

## Requirements

* Raspberry Pi 3 Model B with Jessie Lite
* I2C enabled
* WiringPi
* HD44780 -based LCD character display

## Change Log

### 0.9.0  Development version with LCD and GPIO -support.

## Links

* http://www.ti.com/product/LDC1614 
