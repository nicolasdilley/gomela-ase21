
// https://github.com/rclone/rclone/blob/master/backend/memory/memory.go#L280
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_list2800 = [1] of {int};
	run list280(child_list2800)
stop_process:skip
}

proctype list280(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef b_mu;
	run mutexMonitor(b_mu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	b_mu.RLock!false;
	goto stop_process;
	stop_process: skip;
		b_mu.RUnlock!false;
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

