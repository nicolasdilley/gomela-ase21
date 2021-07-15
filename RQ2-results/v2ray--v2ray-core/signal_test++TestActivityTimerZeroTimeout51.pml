
// https://github.com/v2ray/v2ray-core/blob/master/common/signal/timer_test.go#L51
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestActivityTimerZeroTimeout510 = [1] of {int};
	run TestActivityTimerZeroTimeout51(child_TestActivityTimerZeroTimeout510)
stop_process:skip
}

proctype TestActivityTimerZeroTimeout51(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef timer_checkTask_access;
	run mutexMonitor(timer_checkTask_access);
	do
	:: true -> 
		break
	:: true -> 
		break
	od;
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

