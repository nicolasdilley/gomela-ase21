
// https://github.com/istio/istio/blob/master/pilot/pkg/networking/core/v1alpha3/sidecar_simulation_test.go#L73
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestInboundClusters730 = [1] of {int};
	run TestInboundClusters73(child_TestInboundClusters730)
stop_process:skip
}

proctype TestInboundClusters73(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef serviceAlt_Mutex;
	Mutexdef service_Mutex;
	Mutexdef proxy_Locality_state_atomicMessageInfo_initMu;
	run mutexMonitor(proxy_Locality_state_atomicMessageInfo_initMu);
	run mutexMonitor(service_Mutex);
	run mutexMonitor(serviceAlt_Mutex);
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

