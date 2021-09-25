pragma solidity ^0.4.0;
pragma experimental ABIEncoderV2;

contract logs
{
    struct logs 
    {
        string obj1_pk;
        string obj2_pk;
        string action;
        string role;
        string time_stamp;
        string status;
        string tx_hash;
        string blockHash;
        string blockNo;
        string gasused;
        string name;
    }
    
    mapping (uint => logs) public logs_struct;
    uint public logs_struct_count;
    
    
    //show logs for objects 
    
    
    function add_log(string obj1_pk,string obj2_pk,string _action,string _role,string _time_stamp,string _status,string _tx_hash, string _block_hash, string _block_no, string _gas_used, string _name) public returns (int)
    {
       
        logs_struct_count++;
        logs_struct[logs_struct_count] = logs(obj1_pk,obj2_pk,_action,_role,_time_stamp,_status,_tx_hash, _block_hash, _block_no, _gas_used, _name);
        return 1;
    }
    
    
    function add_log_without_tx(string obj1_pk,string obj2_pk,string _action,string _role,string _time_stamp,string _status,  string _block_hash, string _block_no, string _gas_used, string _name) public returns (int)
    {
       
        logs_struct_count++;
        logs_struct[logs_struct_count] = logs(obj1_pk,obj2_pk,_action,_role,_time_stamp,_status,"", _block_hash, _block_no, _gas_used,_name);
        return 1;
    }
    
    
    
    function show_logs_obj(string _pk) public returns (string[])
    {
        string [] obj_logs;
        for(uint i = 1; i <= logs_struct_count; i++)
        {
            logs temp = logs_struct[i];
            if(stringsEqual(temp.obj1_pk,_pk) ||stringsEqual(temp.obj2_pk,_pk) )
            {
                obj_logs.push(temp.obj1_pk);
                obj_logs.push(temp.obj2_pk);
                obj_logs.push(temp.action);
                obj_logs.push(temp.role);
                obj_logs.push(temp.time_stamp);
                obj_logs.push(temp.status);
                obj_logs.push(temp.tx_hash); // return tuble tomoro zoka
                obj_logs.push(temp.blockHash);
                obj_logs.push(temp.blockNo);
                obj_logs.push(temp.gasused);
                obj_logs.push(temp.name);
                
            }
        }
        
        return obj_logs;
    }
    
    function show_logs() public returns (string[])
    {
        string [] obj_logs;
        for(uint i = 1; i <= logs_struct_count; i++)
        {
            logs temp = logs_struct[i];
            obj_logs.push(temp.obj1_pk);
            obj_logs.push(temp.obj2_pk);
            obj_logs.push(temp.action);
            obj_logs.push(temp.role);
            obj_logs.push(temp.time_stamp);
            obj_logs.push(temp.status);
            obj_logs.push(temp.tx_hash);
            obj_logs.push(temp.blockHash);
            obj_logs.push(temp.blockNo);
            obj_logs.push(temp.gasused);
            obj_logs.push(temp.name);
            
        }
        
        return obj_logs;
    }
    
    // logs version 2
    
    function get_logs_count() public returns(uint)
    {
        return logs_struct_count;
    }
    
    function view_obj_logs(string _pk,uint _ind) public returns (string[])
    {
        string [] obj_logs;
        logs temp = logs_struct[_ind];
        if(stringsEqual(temp.obj1_pk,_pk) ||stringsEqual(temp.obj2_pk,_pk) )
        {
            obj_logs.push(temp.obj1_pk);
            obj_logs.push(temp.obj2_pk);
            obj_logs.push(temp.action);
            obj_logs.push(temp.role);
            obj_logs.push(temp.time_stamp);
            obj_logs.push(temp.status);
            obj_logs.push(temp.tx_hash);
            obj_logs.push(temp.blockHash);
            obj_logs.push(temp.blockNo);
            obj_logs.push(temp.gasused);
            obj_logs.push(temp.name);
        }
        
        return obj_logs;
    }
    
    function view_all_logs(uint _ind) public returns(string[])
    {
        string [] obj_logs;
        logs temp = logs_struct[_ind];
        obj_logs.push(temp.obj1_pk);
        obj_logs.push(temp.obj2_pk);
        obj_logs.push(temp.action);
        obj_logs.push(temp.role);
        obj_logs.push(temp.time_stamp);
        obj_logs.push(temp.status);
        obj_logs.push(temp.tx_hash);
        obj_logs.push(temp.blockHash);
        obj_logs.push(temp.blockNo);
        obj_logs.push(temp.gasused);
        obj_logs.push(temp.name);
        return obj_logs;
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