
// https://github.com/mattermost/mattermost-server/blob/master/store/storetest/post_store.go#L203
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_testPostStoreSaveMultiple2030 = [1] of {int};
	run testPostStoreSaveMultiple203(child_testPostStoreSaveMultiple2030)
stop_process:skip
}

proctype testPostStoreSaveMultiple203(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef p4_propsMu;
	Mutexdef p3_propsMu;
	Mutexdef p2_propsMu;
	Mutexdef p1_propsMu;
	run mutexMonitor(p1_propsMu);
	run mutexMonitor(p2_propsMu);
	run mutexMonitor(p3_propsMu);
	run mutexMonitor(p4_propsMu);
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

