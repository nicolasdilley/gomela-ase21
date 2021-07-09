
// https://github.com/hashicorp/consul/blob/master/tlsutil/config_test.go#L929
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestConfigurator_OutgoingRPCConfig9290 = [1] of {int};
	run TestConfigurator_OutgoingRPCConfig929(child_TestConfigurator_OutgoingRPCConfig9290)
stop_process:skip
}

proctype TestConfigurator_OutgoingRPCConfig929(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef tlsConf_mutex;
	run mutexMonitor(tlsConf_mutex);
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

