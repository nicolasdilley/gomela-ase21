
// https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/pleg/generic_test.go#L515
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRelistingWithSandboxes5150 = [1] of {int};
	run TestRelistingWithSandboxes515(child_TestRelistingWithSandboxes5150)
stop_process:skip
}

proctype TestRelistingWithSandboxes515(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef runtime_T_context_mu;
	Mutexdef runtime_T_context_match_mu;
	Mutexdef testPleg_runtime_T_context_mu;
	Mutexdef testPleg_runtime_T_context_match_mu;
	run mutexMonitor(testPleg_runtime_T_context_match_mu);
	run mutexMonitor(testPleg_runtime_T_context_mu);
	run mutexMonitor(runtime_T_context_match_mu);
	run mutexMonitor(runtime_T_context_mu);
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

