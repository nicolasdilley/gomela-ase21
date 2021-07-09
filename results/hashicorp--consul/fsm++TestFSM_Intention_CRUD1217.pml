
// https://github.com/hashicorp/consul/blob/master/agent/consul/fsm/commands_oss_test.go#L1217
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFSM_Intention_CRUD12170 = [1] of {int};
	run TestFSM_Intention_CRUD1217(child_TestFSM_Intention_CRUD12170)
stop_process:skip
}

proctype TestFSM_Intention_CRUD1217(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef fsm_state_lockDelay_lock;
	Mutexdef fsm_state_db_db_writer;
	Mutexdef fsm_stateLock;
	run mutexMonitor(fsm_stateLock);
	run mutexMonitor(fsm_state_db_db_writer);
	run mutexMonitor(fsm_state_lockDelay_lock);
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

