
// https://github.com/prometheus/prometheus/blob/master/storage/remote/intern_test.go#L29
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestIntern290 = [1] of {int};
	run TestIntern29(child_TestIntern290)
stop_process:skip
}

proctype TestIntern29(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_intern570 = [1] of {int};
	Mutexdef interner_mtx;
	run mutexMonitor(interner_mtx);
	run intern57(interner_mtx,child_intern570);
	child_intern570?0;
	stop_process: skip;
	child!0
}
proctype intern57(Mutexdef p_mtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	p_mtx.RLock!false;
	p_mtx.RUnlock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	p_mtx.Lock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		p_mtx.Unlock!false;
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

