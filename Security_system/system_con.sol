pragma solidity ^0.4.0;
pragma experimental ABIEncoderV2;

contract access_control
{
    struct users_assets
    {
        string PK; // private key   BC identity
        string Name;
        string Email;
       // string NId; // National Id
        // zkp_keys   identity
        string _V;
        string _S;
        string _N;
        string role_id;  // RBac Identity
    }

    struct visitor_assets
    {
        string name;
        string email;
        string hash;
        string pk;
    }

    struct init_visiting
    {
        string res_pk;
        string vis_email;
        uint vis_duration; 
        string role_id;
    }

    struct visiting_object_asset
    {
        string vis_email;
        string object_pk;
        string flag;
    }

    struct objects_assets
    {
        string PK; // private key 
        string Name;
        string IP;
        string Location;
    }
    
    
    
    // new struct RBAC Model
    
    struct roles
    {
        string role_id;
        string role_description;
        string role_name;
        string [] permitions;
        string [] permitions_flags; //option
        uint permitions_count;
    }
    
    struct logs 
    {
        string obj1_pk;
        string obj2_pk;
        string action;
        string role;
        string time_stamp;
        string status;
        string tx_hash;
    }
    
    // mapping to make the above structures  numeric accessabile
    mapping (uint => users_assets) public users_assets_struct; 
    mapping (uint => objects_assets) public objects_assets_struct;
    mapping (uint => visitor_assets) public visitor_assets_struct;
    mapping (uint => init_visiting) public init_visiting_struct;
    mapping (uint => visiting_object_asset) public visiting_object_asset_struct;
    mapping (uint => roles) public roles_asset_struct;
    mapping (uint => logs) public logs_struct;
   // integer counter to allow the adding values upon the array of structures as inilization
   uint public   users_assets_struct_count;
   uint public  objects_assets_struct_count;
   uint public  privillage_struct_count;
   uint public asset_log_struct_count;
   uint public visitor_assets_struct_count;
   uint public init_visiting_struct_count;
   uint public visiting_object_asset_struct_count;
   uint public roles_struct_count;
   uint public logs_struct_count;
   // testing vars
  
    uint public f1;
    uint public f2;
    uint public l1;
    uint public l2;
    uint public l3;
    uint public l4;
    uint public l5;
    uint public l6;
    uint public l7;
    // this responsible for adding any object asset
    function add_object_asset(string _pk,string _name,string _ip, string _location) public returns(int)
    {
        objects_assets_struct_count++; // increment count of objects
        objects_assets_struct[objects_assets_struct_count] = objects_assets(_pk,_name,_ip,_location); // add data to struct
      
        return 1;  // flag to confirm adding process
    }
    
    // this responsible for adding any object asset
    function add_user_asset(string _pk,string _name, string _email,string _V,string _S, string _N,string _role_id) public returns(int)
    {
        users_assets_struct_count++; // increment count of objects
        users_assets_struct[users_assets_struct_count] = users_assets(_pk,_name,_email,_V,_S,_N,_role_id); // add data to struct
        return 1;  // flag to confirm adding process
    }

    // this responsible for add new visitor data
    function add_visitor_asset(string _name, string _email, string _hash,string _pk) public returns (int)
    {
        visitor_assets_struct_count++;
        visitor_assets_struct[visitor_assets_struct_count] = visitor_assets(_name,_email,_hash,_pk);
        return 1;
    }
    // this responsible for add visisting request for perosn outside city
    function add_init_visiting(string _res_pk, string _vis_email,uint _duration,string _role_id) public returns (int)
    {
        init_visiting_struct_count++;
        init_visiting_struct[init_visiting_struct_count] = init_visiting(_res_pk,_vis_email,_duration,_role_id);
        return 1;
    }

    function add_visitor_privillage(string _vis_email,string _object_pk,string _flag) public returns (int)
    {
        visiting_object_asset_struct_count++;
        visiting_object_asset_struct[visiting_object_asset_struct_count] = visiting_object_asset(_vis_email,_object_pk,_flag);
        return 1;
    }

  
    
    function Check_Authentication_role_based(string _UserPk,string _ObjectPK) public returns(int)
    {
        // get user role id
        for(uint i = 1; i <= users_assets_struct_count; i++ )
        {
            users_assets temp_user = users_assets_struct[i];
            l1 = 1;
            if(stringsEqual(temp_user.PK,_UserPk))
            {
                string temp_role_id = temp_user.role_id;
                l2 = 1;
                // select role
                for(uint j = 1; j <= roles_struct_count; j++)
                {
                    roles temp_role = roles_asset_struct[j];
                    l3 = 1;
                    if(stringsEqual(temp_role.role_id,temp_role_id))
                    {
                        //check permitions
                        l4 = 1;
                        for(uint k = 0; k < temp_role.permitions_count; k++)  // array in solidity start from 0
                        {
                            if(stringsEqual(temp_role.permitions[k],_ObjectPK))
                            {
                                // permition found now check its flag
                                l5 = 1;
                                if(stringsEqual(temp_role.permitions_flags[k],'1'))
                                {
                                    l6 = 1;
                                    f2 = 1;
                                    return 1;
                                }else
                                {
                                    l7 = 1;
                                    f2 = 0;
                                    return 0;   
                                }
                            }
                        }
                    }
                }
            }
        }
        f2 = 0;
        return 0;
    }
    
    function Check_Authentication_role_based_vis(string _hash,string _ObjectPK) public returns(int)
    {
        for(uint i = 1;i <= visitor_assets_struct_count; i++)
        {
            visitor_assets temp_vis = visitor_assets_struct[i];
            l1 = 1;
            if(stringsEqual(temp_vis.hash,_hash))
            {
                //Vis Found 
                // Get its Role
                l2 = 1;
                string temp_vis_email = temp_vis.email;
                for(uint j = 1; j <= init_visiting_struct_count; j++)
                {
                    init_visiting temp_init_data = init_visiting_struct[j];
                    if(stringsEqual(temp_init_data.vis_email,temp_vis_email))
                    {
                        if(temp_init_data.vis_duration > 0)
                        {
                            
                            
                             //get role id
                            l3 = 1;
                            string temp_role_id = temp_init_data.role_id;
                         // select role
                            for(uint e = 1; e <= roles_struct_count; e++)
                            {
                                roles temp_role = roles_asset_struct[e];
                                if(stringsEqual(temp_role.role_id,temp_role_id))
                                {
                                    l4 = 1;
                                    //check permitions
                                    for(uint k = 0; k < temp_role.permitions_count; k++)  // array in solidity start from 0
                                    {
                                        if(stringsEqual(temp_role.permitions[k],_ObjectPK))
                                        {
                                            // permition found now check its flag
                                            l5 = 1;
                                            if(stringsEqual(temp_role.permitions_flags[k],'1'))
                                            {
                                                l6 = 1;
                                                f1 = 1;
                                                temp_init_data.vis_duration--;
                                                return 1;
                                            }else
                                            {
                                                l7 = 1;
                                                f1 = 0;
                                                return 0;   
                                            }
                                        }
                                    }
                                }
                            }
                        }
                       
                    }
                }
            }
        }
        
        f1 = 0;
        return 0;
    }
    
    // Add Role function
    
    function add_role(string _role_id,string _role_name,string _role_description) public returns (int)
    {
        roles_struct_count++;
        //materials_struct[materials_struct_count].id = _id;
        roles_asset_struct[roles_struct_count].role_id = _role_id;
        roles_asset_struct[roles_struct_count].role_name = _role_name;
        roles_asset_struct[roles_struct_count].role_description = _role_description;
        return 1;
    }
    
    // Add permitions 
    
    function add_permition(string _role_id,string _perm, string _flag) public returns (int)
    {
        for(uint i = 1; i <= roles_struct_count ; i++)
        {
            roles obj = roles_asset_struct[i];
            if(stringsEqual(obj.role_id,_role_id))
            {
                obj.permitions_count++; // array start from 0 
                obj.permitions.push(_perm);
                obj.permitions_flags.push(_flag);
                
            }
            
        }
        return 1;
    }
    
    function get_role_name(string _pk) public returns (string)
    {
        for (uint i = 1; i <= users_assets_struct_count; i++)
        {
            users_assets temp = users_assets_struct[i];
            if(stringsEqual(temp.PK,_pk))
            {
                for(uint j = 1; j <= roles_struct_count ; j++)
                {
                    roles obj = roles_asset_struct[j];
                    if(stringsEqual(obj.role_id,temp.role_id))
                    {
                        return obj.role_name;
                    }
                }
            }
        }
        
        for(uint k =1; k <= visitor_assets_struct_count; k++)
        {
            visitor_assets temp_vis = visitor_assets_struct[k];
            if(stringsEqual(temp_vis.pk,_pk))
            {
                for(uint o = 1; o <= roles_struct_count ; o++)
                {
                    roles obj2 = roles_asset_struct[o];
                    if(stringsEqual(obj2.role_id,temp.role_id))
                    {
                        return obj.role_name;
                    }
                }
            }
        }
        
        return "NULL";
    }
    
    function get_object_pk(string _name) public returns (string)
    {
        for(uint i = 1; i <= objects_assets_struct_count; i++)
        {
            objects_assets temp = objects_assets_struct[i];
            if(stringsEqual(temp.Name,_name))
            {
                return temp.PK;
            }
        }
        
        return "NULL";
    }
    
    function login(string _email) public returns (string)
    {
        for(uint i = 1; i <= users_assets_struct_count; i++ )
        {
            users_assets temp_user = users_assets_struct[i];
            if(stringsEqual(temp_user.Email,_email))
            {
                return temp_user.PK;
            }
        }
        
        for(uint j = 1; j <= visitor_assets_struct_count; j++ )
        {
            visitor_assets temp_vis = visitor_assets_struct[j];
            if(stringsEqual(temp_vis.email,_email))
            {
                return temp_vis.hash;
            }
        }
        
        return 'NULL';
    }
    
    function add_log(string obj1_pk,string obj2_pk,string _action,string _role,string _time_stamp,string _status,string _tx_hash) public returns (int)
    {
       
        logs_struct_count++;
        logs_struct[logs_struct_count] = logs(obj1_pk,obj2_pk,_action,_role,_time_stamp,_status,_tx_hash);
        return 1;
    }
    
    
    //show logs for objects 
    
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
