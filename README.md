# fhem_98_ModbusMD0X
FHEM module for MD-01 and MD-02 modbus device

This is temperature and humidity sensor with RS485 modbus RTU interface.

Using as other Modbus devices:
### XY-MD02 ID 22, on ew11-2
define MD01_01_ew112 ModbusMD0X 22 30 192.168.200.65:8899 RTU
attr MD01_01_ew112 room Zahrada
attr MD01_01_ew112 alias sklenik
attr MD01_01_ew112 verbose 0
attr MD01_01_ew112 enableControlSet 1
attr MD01_01_ew112 stateFormat {sprintf("T:%.1f H:%.1f", ReadingsVal($name,"Temperature",-99), ReadingsVal($name,"Humidity",99) ) }

Or
define MD01_01_ew112 ModbusMD0X 22 30
attr MD01_01_ew112 IODev MODBUSDEV
...
