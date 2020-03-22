# fhem_98_ModbusMD0X
FHEM module for MD-01 and MD-02 modbus device

XY-MD02 is temperature and humidity modbus device connected by RS485 with DIN35 mounting rails

Use modbus RTU or simple ASCII protocol

RS485 SIMPLE ASCII protocol:
CMD   instructions

READ	Report triggered a temperature and humidity
      (27.4℃,67.7%)
AUTO	Start the temperature and humidity automatically report function(Same as above)
STOP	Stop the temperature and humidity automatically report function
BR:XXXX	Set the baud rate 9600~19200 (BR:9600)
TC:XX.X	Set the temperature calibration(-10.0~10.0) 
    	(TC:02.0℃)
HC:XX.X	Set the humidityration(-10.0~10.0) 
    	(HC:-05.1%)
HZ:XXX	Set the temperature and humidity reporting rate(0.5,1,2,5,10)
    	(HZ:2 reporting rate 2Hz)
PARAM	Read the system current Settings

PARAM CMD:
TC:0.0,HC:0.0,BR:9600,HZ:1	->Temp calibration 0.0, Humi calibration0.0, Baud rate 9600,report rate 1Hz
SLAVE_ADD:1			->MODBUS Slave address 1

