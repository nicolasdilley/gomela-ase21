
// https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/kuberuntime/kuberuntime_image_test.go#L179
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestImageStatsWithError1790 = [1] of {int};
	run TestImageStatsWithError179(child_TestImageStatsWithError1790)
stop_process:skip
}

proctype TestImageStatsWithError179(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ImageStats1330 = [1] of {int};
	Mutexdef fakeManager_logReduction_errorMapLock;
	run mutexMonitor(fakeManager_logReduction_errorMapLock);
	run ImageStats133(fakeManager_logReduction_errorMapLock,child_ImageStats1330);
	child_ImageStats1330?0;
	stop_process: skip;
	child!0
}
proctype ImageStats133(Mutexdef m_logReduction_errorMapLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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

