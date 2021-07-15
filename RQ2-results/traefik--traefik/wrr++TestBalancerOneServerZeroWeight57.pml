
// https://github.com/traefik/traefik/blob/master/pkg/server/service/loadbalancer/wrr/wrr_test.go#L57
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBalancerOneServerZeroWeight570 = [1] of {int};
	run TestBalancerOneServerZeroWeight57(child_TestBalancerOneServerZeroWeight570)
stop_process:skip
}

proctype TestBalancerOneServerZeroWeight57(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ServeHTTP1053 = [1] of {int};
	chan child_ServeHTTP1052 = [1] of {int};
	chan child_AddService1401 = [1] of {int};
	chan child_AddService1400 = [1] of {int};
	Mutexdef balancer_mutex;
	run mutexMonitor(balancer_mutex);
	run AddService140(balancer_mutex,child_AddService1400);
	child_AddService1400?0;
	run AddService140(balancer_mutex,child_AddService1401);
	child_AddService1401?0;
	

	if
	:: 0 != -2 && 3-1 != -3 -> 
				for(i : 0.. 3-1) {
			for13: skip;
			run ServeHTTP105(balancer_mutex,child_ServeHTTP1053);
			child_ServeHTTP1053?0;
			for13_end: skip
		};
		for13_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run ServeHTTP105(balancer_mutex,child_ServeHTTP1052);
			child_ServeHTTP1052?0;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype AddService140(Mutexdef b_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	b_mutex.RLock!false;
	b_mutex.RUnlock!false;
	stop_process: skip;
	child!0
}
proctype ServeHTTP105(Mutexdef b_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_nextServer842 = [1] of {int};
	run nextServer84(b_mutex,child_nextServer842);
	child_nextServer842?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype nextServer84(Mutexdef b_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	b_mutex.Lock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		b_mutex.Unlock!false;
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

