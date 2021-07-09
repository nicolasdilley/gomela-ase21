
// https://github.com/rclone/rclone/blob/master/lib/cache/cache_test.go#L234
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestGetMaybe2340 = [1] of {int};
	run TestGetMaybe234(child_TestGetMaybe2340)
stop_process:skip
}

proctype TestGetMaybe234(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetMaybe1414 = [1] of {int};
	chan child_Clear2193 = [1] of {int};
	chan child_GetMaybe1412 = [1] of {int};
	chan child_Get811 = [1] of {int};
	chan child_GetMaybe1410 = [1] of {int};
	Mutexdef c_mu;
	run mutexMonitor(c_mu);
	run GetMaybe141(c_mu,child_GetMaybe1410);
	child_GetMaybe1410?0;
	run Get81(c_mu,child_Get811);
	child_Get811?0;
	run GetMaybe141(c_mu,child_GetMaybe1412);
	child_GetMaybe1412?0;
	run Clear219(c_mu,child_Clear2193);
	child_Clear2193?0;
	run GetMaybe141(c_mu,child_GetMaybe1414);
	child_GetMaybe1414?0;
	stop_process: skip;
	child!0
}
proctype GetMaybe141(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_used710 = [1] of {int};
	c_mu.Lock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run used71(c_mu,child_used710);
	child_used710?0;
	goto stop_process;
	stop_process: skip;
		c_mu.Unlock!false;
	child!0
}
proctype used71(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype Get81(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_used712 = [1] of {int};
	chan child_noCache401 = [1] of {int};
	c_mu.Lock!false;
	

	if
	:: true -> 
		c_mu.Unlock!false;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		c_mu.Lock!false;
		run noCache40(c_mu,child_noCache401);
		child_noCache401?0
	:: true;
	fi;
	run used71(c_mu,child_used712);
	child_used712?0;
	goto stop_process;
	stop_process: skip;
		c_mu.Unlock!false;
	child!0
}
proctype noCache40(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Clear219(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_mu.Lock!false;
	c_mu.Unlock!false;
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

