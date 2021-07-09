#define TestServerGRPCTLS_tests  0

// https://github.com/jaegertracing/jaeger/blob/master/cmd/query/app/server_test.go#L443
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestServerGRPCTLS4430 = [1] of {int};
	run TestServerGRPCTLS443(child_TestServerGRPCTLS4430)
stop_process:skip
}

proctype TestServerGRPCTLS443(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef enabledTLSCfg_certWatcher_mu;
	Mutexdef enabledTLSCfg_certWatcher_watcher_mu;
	Mutexdef disabledTLSCfg_certWatcher_mu;
	Mutexdef disabledTLSCfg_certWatcher_watcher_mu;
	int tests = TestServerGRPCTLS_tests;
	run mutexMonitor(disabledTLSCfg_certWatcher_watcher_mu);
	run mutexMonitor(disabledTLSCfg_certWatcher_mu);
	run mutexMonitor(enabledTLSCfg_certWatcher_watcher_mu);
	run mutexMonitor(enabledTLSCfg_certWatcher_mu);
	for10_exit: skip;
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

