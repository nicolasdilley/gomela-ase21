
// https://github.com/pingcap/tidb/blob/master/executor/checksum.go#L208
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_appendRequest2080 = [1] of {int};
	run appendRequest208(child_appendRequest2080)
stop_process:skip
}

proctype appendRequest208(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef req_MemTracker_parMu;
	Mutexdef req_MemTracker_actionMu;
	Mutexdef req_MemTracker_mu;
	run mutexMonitor(req_MemTracker_mu);
	run mutexMonitor(req_MemTracker_actionMu);
	run mutexMonitor(req_MemTracker_parMu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

