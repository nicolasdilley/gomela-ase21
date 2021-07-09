
// https://github.com/valyala/fasthttp/blob/master/client_test.go#L1847
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestClientIdempotentRequest18470 = [1] of {int};
	run TestClientIdempotentRequest1847(child_TestClientIdempotentRequest18470)
stop_process:skip
}

proctype TestClientIdempotentRequest1847(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Post3482 = [1] of {int};
	chan child_Post3481 = [1] of {int};
	chan child_Get3100 = [1] of {int};
	Mutexdef c_mLock;
	Mutexdef c_TLSConfig_mutex;
	run mutexMonitor(c_TLSConfig_mutex);
	run mutexMonitor(c_mLock);
	run Get310(c_TLSConfig_mutex,c_mLock,child_Get3100);
	child_Get3100?0;
	run Post348(c_TLSConfig_mutex,c_mLock,child_Post3481);
	child_Post3481?0;
	run Post348(c_TLSConfig_mutex,c_mLock,child_Post3482);
	child_Post3482?0;
	stop_process: skip;
	child!0
}
proctype Get310(Mutexdef c_TLSConfig_mutex;Mutexdef c_mLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_clientGetURL8410 = [1] of {int};
	run clientGetURL841(c_TLSConfig_mutex,c_mLock,child_clientGetURL8410);
	child_clientGetURL8410?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype clientGetURL841(Mutexdef c_TLSConfig_mutex;Mutexdef c_mLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_doRequestFollowRedirectsBuffer9660 = [1] of {int};
	run doRequestFollowRedirectsBuffer966(c_TLSConfig_mutex,c_mLock,child_doRequestFollowRedirectsBuffer9660);
	child_doRequestFollowRedirectsBuffer9660?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype doRequestFollowRedirectsBuffer966(Mutexdef c_TLSConfig_mutex;Mutexdef c_mLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_doRequestFollowRedirects9830 = [1] of {int};
	run doRequestFollowRedirects983(c_TLSConfig_mutex,c_mLock,child_doRequestFollowRedirects9830);
	child_doRequestFollowRedirects9830?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype doRequestFollowRedirects983(Mutexdef c_TLSConfig_mutex;Mutexdef c_mLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Post348(Mutexdef c_TLSConfig_mutex;Mutexdef c_mLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_clientPostURL9361 = [1] of {int};
	run clientPostURL936(c_TLSConfig_mutex,c_mLock,child_clientPostURL9361);
	child_clientPostURL9361?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype clientPostURL936(Mutexdef c_TLSConfig_mutex;Mutexdef c_mLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_doRequestFollowRedirectsBuffer9661 = [1] of {int};
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	run doRequestFollowRedirectsBuffer966(c_TLSConfig_mutex,c_mLock,child_doRequestFollowRedirectsBuffer9661);
	child_doRequestFollowRedirectsBuffer9661?0;
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

