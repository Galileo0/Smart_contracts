pragma solidity ^0.4.0;

contract power_consumtion
{
    struct readings
    {
        string date_time;
        string recently_current;
        string total_current;
        string device_name;
        string device_address;
        string controller_address;
    }
    
    struct devices 
    {
        string device_name;
        string device_address;
    }
    
    mapping (uint => readings) public readings_struct;
    mapping (uint => devices) public devices_struct;
    uint public readings_struct_count;
    uint public devices_struct_count;
    
    function add_device(string _name,string _address) public returns (int)
    {
        devices_struct_count++;
        devices_struct[devices_struct_count] = devices(_name,_address);
        return 1;
    }
    
    function add_readings(string _date_time,string _recently_current,string _total_current,string _device_name,string _device_address,string _controller_address) public returns (int)
    {
        readings_struct_count++;
        readings_struct[readings_struct_count] = readings(_date_time,_recently_current,_total_current,_device_name,_device_address,_controller_address);
        return 1;
    }
    
    function get_device_address(string _name) public returns(string)
    {
        for(uint i = 1; i <= devices_struct_count; i++)
        {
            devices temp = devices_struct[i];
            if(stringsEqual(temp.device_name,_name))
            {
                return temp.device_address;
            }
        }
        return "NULL";
    }
    
    
    // comparsion function that checks the equality of two string
    function stringsEqual(string storage _a, string memory _b) internal returns (bool) {
		bytes storage a = bytes(_a);
		bytes memory b = bytes(_b);
		if (a.length != b.length)
			return false;
		// @todo unroll this loop
		for (uint i = 0; i < a.length; i++)
			if (a[i] != b[i])
				return false;
		return true;
	}
}