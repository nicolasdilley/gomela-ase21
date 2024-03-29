
// https://github.com/hashicorp/terraform/blob/master/command/views/hook_ui_test.go#L299
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPreProvisionInstanceStep2990 = [1] of {int};
	run TestPreProvisionInstanceStep299(child_TestPreProvisionInstanceStep2990)
stop_process:skip
}

proctype TestPreProvisionInstanceStep299(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_PreProvisionInstanceStep2220 = [1] of {int};
	Mutexdef h_resourcesLock;
	Mutexdef h_viewLock;
	run mutexMonitor(h_viewLock);
	run mutexMonitor(h_resourcesLock);
	run PreProvisionInstanceStep222(h_viewLock,h_resourcesLock,child_PreProvisionInstanceStep2220);
	child_PreProvisionInstanceStep2220?0;
	stop_process: skip;
	child!0
}
proctype PreProvisionInstanceStep222(Mutexdef h_viewLock;Mutexdef h_resourcesLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_println2850 = [1] of {int};
	run println285(h_viewLock,h_resourcesLock,child_println2850);
	child_println2850?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype println285(Mutexdef h_viewLock;Mutexdef h_resourcesLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	h_viewLock.Lock!false;
	stop_process: skip;
		h_viewLock.Unlock!false;
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

