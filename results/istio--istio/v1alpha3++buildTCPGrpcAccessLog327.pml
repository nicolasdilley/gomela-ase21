
// https://github.com/istio/istio/blob/master/pilot/pkg/networking/core/v1alpha3/accesslog.go#L327
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_buildTCPGrpcAccessLog3270 = [1] of {int};
	run buildTCPGrpcAccessLog327(child_buildTCPGrpcAccessLog3270)
stop_process:skip
}

proctype buildTCPGrpcAccessLog327(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef filter_state_atomicMessageInfo_initMu;
	Mutexdef fl_CommonConfig_BufferSizeBytes_state_atomicMessageInfo_initMu;
	Mutexdef fl_CommonConfig_BufferFlushInterval_state_atomicMessageInfo_initMu;
	Mutexdef fl_CommonConfig_GrpcService_Timeout_state_atomicMessageInfo_initMu;
	Mutexdef fl_CommonConfig_GrpcService_state_atomicMessageInfo_initMu;
	Mutexdef fl_CommonConfig_state_atomicMessageInfo_initMu;
	Mutexdef fl_state_atomicMessageInfo_initMu;
	run mutexMonitor(fl_state_atomicMessageInfo_initMu);
	run mutexMonitor(fl_CommonConfig_state_atomicMessageInfo_initMu);
	run mutexMonitor(fl_CommonConfig_GrpcService_state_atomicMessageInfo_initMu);
	run mutexMonitor(fl_CommonConfig_GrpcService_Timeout_state_atomicMessageInfo_initMu);
	run mutexMonitor(fl_CommonConfig_BufferFlushInterval_state_atomicMessageInfo_initMu);
	run mutexMonitor(fl_CommonConfig_BufferSizeBytes_state_atomicMessageInfo_initMu);
	run mutexMonitor(filter_state_atomicMessageInfo_initMu);
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

