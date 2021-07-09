
// https://github.com/k6io/k6/blob/master/output/helpers_test.go#L34
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestSampleBufferBasics340 = [1] of {int};
	run TestSampleBufferBasics34(child_TestSampleBufferBasics340)
stop_process:skip
}

proctype TestSampleBufferBasics34(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef single_Metric_Thresholds_Runtime_vm_interruptLock;
	Mutexdef single_Metric_Thresholds_Runtime_vm_prg_src_mu;
	run mutexMonitor(single_Metric_Thresholds_Runtime_vm_prg_src_mu);
	run mutexMonitor(single_Metric_Thresholds_Runtime_vm_interruptLock);
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

