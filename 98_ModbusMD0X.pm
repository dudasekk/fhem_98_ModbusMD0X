##############################################
# $Id: 98_ModbusMD0X.pm $
# von ModbusAttr generiertes Modul 
# Edited by KD 2019-06-16

package main;
use strict;
use warnings;

sub ModbusMD0X_Initialize($);
my %ModbusMD0XparseInfo = (
          "h00257" =>  {       'reading' => 'DeviceAddress',
                               'name' => 'Device Address',
		               'poll' => "once",
		               'polldelay' => 3600,
			       'set' => 1,
			       'min' => 1,
			       'unpack' => 'n',
			       'showGet' => 1,
			       'format' => "%s",
			       'max' => 247
                       },
# Baud rate 0 ... 9600; 1 ... 14400; 2 ... 19200
          "h00258" =>  {       'reading' => 'BaudRate',
                               'name' => 'Baud_rate',
		               'poll' => "once",
		               'polldelay' => 3600,
			       'hint' => '0,1,2',
			       'unpack' => 'n',
			       'map' => "0:9600, 1:14400, 2:19200",
			       'format' => "%s",
			       'set' => 1,
			       'min' => 0,
			       'max' => 2
                       },
          "h00259" =>  {       'reading' => 'TempCorr',
                               'name' => 'Temperature correction',
		               'poll' => "once",
		               'polldelay' => 3600,
			       'set' => 1,
			       'unpack' => 's>',
			       'format' => "%d",
			       'min' => -10,
			       'max' => 10
                       },
          "h00260" =>  {       'reading' => 'HumiCorr',
                               'name' => 'Humidity correction',
		               'poll' => "once",
		               'polldelay' => 3600,
			       'unpack' => 's>',
			       'format' => "%d",
			       'set' => 1,
			       'min' => -10,
			       'max' => 10,
                       },
              "i1" =>  {       'expr' => '$val/10',
		               'poll' => 1,
			       'unpack'  => "s>",
                               'reading' => 'Temperature',
                               'name' => 'Temperature'
                       },
              "i2" =>  {       'expr' => '$val/10',
		               'poll' => 1,
			       'unpack'  => "s>",
                               'reading' => 'Humidity',
                               'name' => 'Humidity'
                          }
);

my %ModbusMD0XdeviceInfo = (
               "h" =>  {       'defExpr' => 'ModbusLD_ScanFormat($hash, $val)',
                                'defLen' => '1',
                             'defUnpack' => 'a2',
                            'defShowGet' => '1',
                       },
               "i" =>  {       'combine' => '2',
                               'defPoll' => '1',
                            'defShowGet' => '1',
                          }
);


#####################################
sub ModbusMD0X_Initialize($)
{
    my ($modHash) = @_;

    require "$attr{global}{modpath}/FHEM/DevIo.pm";
    #require "$attr{global}{modpath}/FHEM/98_Modbus.pm";
    LoadModule "Modbus";

    $modHash->{parseInfo}  = \%ModbusMD0XparseInfo;  # defines registers, inputs, coils etc. for this Modbus Defive
    $modHash->{deviceInfo} = \%ModbusMD0XdeviceInfo; # defines properties of the device like defaults and supported function codes

    ModbusLD_Initialize($modHash);              # Generic function of the Modbus module does the rest
    
    $modHash->{AttrList} = $modHash->{AttrList} . " " .     # Standard Attributes like IODEv etc 
        $modHash->{ObjAttrList} . " " .                     # Attributes to add or overwrite parseInfo definitions
        $modHash->{DevAttrList} . " " .                     # Attributes to add or overwrite devInfo definitions
        "poll-.* " .                                        # overwrite poll with poll-ReadingName
        "polldelay-.* ";                                    # overwrite polldelay with polldelay-ReadingName
}


=pod
=item summary    Module to work with SHT modbus XY-MD01 and XY-MD02
=item summary_DE Modul für SHT modbus XY-MD01 and XY-MD02
=begin html

<a name="ModbusMD0X"></a>
<h3>ModbusMD0X</h3>
<ul>
    ModbusMD0X uses the low level Modbus module to provide a way to communicate with the XY-MD01 or XY-MD02.
    It defines the modbus holding registers for the different values and reads them in a defined interval.
    <br /><br />

    <b>Prerequisites</b>
        <ul>
        <b>This module requires the basic <a href="#Modbus">Modbus</a> module which itsef requires Device::SerialPort or Win32::SerialPort module.</b>
    </ul><br />

<a name="ModbusMD0XDefine"></a>
    <b>Define</b>
    <ul>
    <code>define &lt;name&gt; ModbusMD0X &lt;ID&gt; &lt;Interval&gt;</code><br /><br />
    The module connects to the MD0X with the Modbus Id &lt;ID&gt; through an already defined Modbus device and actively requests data from the system every &lt;Interval&gt; seconds.<br /><br />
    Example:<br>
    <code>define MD01_01 ModbusMD0X 1 60</code>
    </ul><br />

<a name="ModbusMD0XSet"></a>
    <b>Set-Commands</b>
        <ul>
    The following set options are available:
    <ul>
        <li>Device Address</li>
        <li>Baud rate</li>
        <li>Temperature correction</li>
        <li>Humidity correction</li>
    </ul>
    All other Readings (along with their Meanings) which can only be read:<br />
    <ul>
        <li>Temperature</li>
        <li>Humidity</li>
    </ul>

    <a name="ModbusMD0XGet"></a>
    <b>Get-Commands</b>
        <ul>
    All readings are also available as Get commands. Internally a Get command triggers
    the corresponding request to the device and then interprets the data and returns
    the correct field value. This is a good way for getting a new current value from
    the Module.
    </ul><br />

    <a name="ModbusMD0Xattr"></a>
    <b>Attribute</b>
        <ul>
        Only centralized Attributes are in use. Especially:
            <ul>
                <li><a href="#readingFnAttributes">readingFnAttributes</a></li>
            </ul>
    </ul><br />
</ul>

=end html

==cut

