
// https://github.com/kubernetes/kubernetes/blob/master/pkg/controller/endpointslicemirroring/endpointslicemirroring_controller_test.go#L49
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_newController490 = [1] of {int};
	run newController49(child_newController490)
stop_process:skip
}

proctype newController49(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef esController_reconciler_metricsCache_lock;
	Mutexdef esController_reconciler_endpointSliceTracker_lock;
	Mutexdef esController_endpointSliceTracker_lock;
	run mutexMonitor(esController_endpointSliceTracker_lock);
	run mutexMonitor(esController_reconciler_endpointSliceTracker_lock);
	run mutexMonitor(esController_reconciler_metricsCache_lock);
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

