
// https://github.com/beego/beego/blob/master/client/httplib/httplib_test.go#L268
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestToFileDir2680 = [1] of {int};
	run TestToFileDir268(child_TestToFileDir2680)
stop_process:skip
}

proctype TestToFileDir268(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ToFile5870 = [1] of {int};
	Mutexdef req_setting_TLSClientConfig_mutex;
	run mutexMonitor(req_setting_TLSClientConfig_mutex);
	run ToFile587(req_setting_TLSClientConfig_mutex,child_ToFile5870);
	child_ToFile5870?0;
	stop_process: skip;
	child!0
}
proctype ToFile587(Mutexdef b_setting_TLSClientConfig_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getResponse4180 = [1] of {int};
	run getResponse418(b_setting_TLSClientConfig_mutex,child_getResponse4180);
	child_getResponse4180?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getResponse418(Mutexdef b_setting_TLSClientConfig_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_DoRequest4310 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run DoRequest431(b_setting_TLSClientConfig_mutex,child_DoRequest4310);
	child_DoRequest4310?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype DoRequest431(Mutexdef b_setting_TLSClientConfig_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_DoRequestWithCtx4350 = [1] of {int};
	run DoRequestWithCtx435(b_setting_TLSClientConfig_mutex,child_DoRequestWithCtx4350);
	child_DoRequestWithCtx4350?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype DoRequestWithCtx435(Mutexdef b_setting_TLSClientConfig_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype mutexMonitor(Mutexdef m) {
bool locked = false;
do
:: true ->
	if
	:: m.Counter > 0 ->
		if 
		:: m.RUnlock?false -> 
			m.Counter = m.Counter - 1;
		:: m.RLock?false -> 
			m.Counter = m.Counter + 1;
		fi;
	:: locked ->
		m.Unlock?false;
		locked = false;
	:: else ->	 end:	if
		:: m.Unlock?false ->
			assert(0==32);		:: m.Lock?false ->
			locked =true;
		:: m.RUnlock?false ->
			assert(0==32);		:: m.RLock?false ->
			m.Counter = m.Counter + 1;
		fi;
	fi;
od
}

