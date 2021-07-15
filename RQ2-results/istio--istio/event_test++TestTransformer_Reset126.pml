
// https://github.com/istio/istio/blob/master/pkg/config/event/transformer_test.go#L126
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestTransformer_Reset1260 = [1] of {int};
	run TestTransformer_Reset126(child_TestTransformer_Reset1260)
stop_process:skip
}

proctype TestTransformer_Reset126(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef accBaz_mu;
	Mutexdef accBar_mu;
	run mutexMonitor(accBar_mu);
	run mutexMonitor(accBaz_mu);
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

