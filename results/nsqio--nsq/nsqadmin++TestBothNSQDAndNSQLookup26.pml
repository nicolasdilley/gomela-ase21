
// https://github.com/nsqio/nsq/blob/master/nsqadmin/nsqadmin_test.go#L26
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBothNSQDAndNSQLookup260 = [1] of {int};
	run TestBothNSQDAndNSQLookup26(child_TestBothNSQDAndNSQLookup260)
stop_process:skip
}

proctype TestBothNSQDAndNSQLookup26(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef __httpClientTLSConfig_mutex;
	run mutexMonitor(__httpClientTLSConfig_mutex);
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

