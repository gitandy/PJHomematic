PJHomematic
===========

PJHomematic is an abstarction of the Homematic JSON-API.

The package interfaces on different depths to the homematic API 

* High level API 
  * Homematic - The API classes and methods are created dynamically to be called directly 
* Low level API
  * hmrpc - An interface to the Homematic JSON-API with session handling 
  * jsonrpc - An implementation of the JSON-RPC protocol
  
The package is tested against the recent RaspberryMatic version only (currently 3.71).
If you find out it is working great with some other platforms please drop me a message or create an [issue](https://github.com/gitandy/PJHomematic/issues) if you experience problems.


Installation
------------
The installation requires a python installation (>= 3.9).
    
    # python3 -m pip install PJHomematic

If you want to be able to export the device list as Excel file via homematic.list_devices (see below) install the extra dependencies (openpyxl)

    # python3 -m pip install PJHomematic[extra]


Usage
-----

To retreive a list of all devices (columns: Name, Type, Address, Subsection, Room, Level) you should run

    # python3 -m homematic.list_devices IP-ADDRESS USERNAME PASSWORD
    
If openpyxl is available the list is written to an excel file. Otherwise it is printed tab separated to the console.


API usage
----------

The following chapters describing the usage of the different API level for the same job.

The JSON-API documentation can be retrieved via

    from pprint import pp
    from homematic import Homematic

    hm = Homematic('http://10.1.1.1', username='user', password='pwd')
    pp(hm.api_doc)
    hm.logout()


### High level API - Homematic class

Example of access via the high level API

    from homematic import Homematic

    hm = Homematic('http://10.1.1.1', username='user', password='pwd')
    print(hm.system.listMethods())
    hm.logout()
    

### Low level API - hmrpc module

Example of access via the low level API

    from homematic import hmrpc

    hmrc = hmrpc.HMRPCClient('http://10.1.1.1', username='user', password='pwd')
    print(hmrc.call('system.listMethods'))
    hmrc.logout()


### Low level API - jsonrpc module

Example of access via the low level API with manual session management

    from homematic import jsonrpc

    jrc = jsonrpc.JSONRPCClient('http://10.1.1.1/api/homematic.cgi')
    session = jrc.call('Session.login', username='user', password='pwd')
    print(jrc.call('system.listMethods'))
    jrc.call('Session.logout', _session_id_=session)

Problems with https
-------------------

If you expierence problems with https consider to use a proper CA signed certifcate 
instead of the default selfsigned cert.

If you are using windows you probably have to install python-certifi-win32 to use your local certificate store

If you need support do not hesitate to ask.


Source Code
-----------
The source code is available at [GitHub](https://github.com/gitandy/PJHomematic)


Copyright
---------
PJHomematic &copy; 2023 by Andreas Schawo is licensed under [CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/) 

[Homematic and Homematic IP](https://homematic-ip.com/de) are trademarks of [eQ-3 AG](https://www.eq-3.de/start.html)
