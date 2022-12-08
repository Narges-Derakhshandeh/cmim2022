%%add 2 bodies to the system and verify they exist
sys=make_system_ND();
sys=add_body_ND(sys, "ground");
sys=add_body_ND(sys, "slider");
 try
     check_body_exists(sys, "ground")
     assert(false, "Body ground not found")
 catch exception
     assert(exception.message=="Body ground not found")
     disp(exception)
 end
 try
     check_body_exists(sys, "slider")
     assert(false, "Body slider not found")
 catch exception
      assert(exception.message=="Body slider not found")
     disp(exception)
 end
 