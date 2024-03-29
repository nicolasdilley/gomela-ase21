
// https://github.com/dapr/dapr/blob/master/pkg/actors/actors_test.go#L755
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCallLocalActor7550 = [1] of {int};
	run TestCallLocalActor755(child_TestCallLocalActor7550)
stop_process:skip
}

proctype TestCallLocalActor755(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef req_r_Actor_state_atomicMessageInfo_initMu;
	Mutexdef req_r_Message_HttpExtension_state_atomicMessageInfo_initMu;
	Mutexdef req_r_Message_Data_state_atomicMessageInfo_initMu;
	Mutexdef req_r_Message_state_atomicMessageInfo_initMu;
	Mutexdef req_r_state_atomicMessageInfo_initMu;
	run mutexMonitor(req_r_state_atomicMessageInfo_initMu);
	run mutexMonitor(req_r_Message_state_atomicMessageInfo_initMu);
	run mutexMonitor(req_r_Message_Data_state_atomicMessageInfo_initMu);
	run mutexMonitor(req_r_Message_HttpExtension_state_atomicMessageInfo_initMu);
	run mutexMonitor(req_r_Actor_state_atomicMessageInfo_initMu);
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

