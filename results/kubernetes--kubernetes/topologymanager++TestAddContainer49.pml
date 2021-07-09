
// https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/cm/topologymanager/scope_test.go#L49
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAddContainer490 = [1] of {int};
	run TestAddContainer49(child_TestAddContainer490)
stop_process:skip
}

proctype TestAddContainer49(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AddContainer970 = [1] of {int};
	chan child_AddContainer971 = [1] of {int};
	Mutexdef scope_mutex;
	int testCases = -2;
	run mutexMonitor(scope_mutex);
	

	if
	:: testCases-1 != -3 -> 
				for(i : 0.. testCases-1) {
			for10: skip;
			run AddContainer97(scope_mutex,child_AddContainer970);
			child_AddContainer970?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run AddContainer97(scope_mutex,child_AddContainer971);
			child_AddContainer971?0;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype AddContainer97(Mutexdef s_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_mutex.Lock!false;
	goto stop_process;
	stop_process: skip;
		s_mutex.Unlock!false;
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

