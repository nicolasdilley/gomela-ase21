
// https://github.com/minio/minio/blob/master/pkg/rpc/server_test.go#L40
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRegisterService400 = [1] of {int};
	run TestRegisterService40(child_TestRegisterService400)
stop_process:skip
}

proctype TestRegisterService40(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_RegisterService1394 = [1] of {int};
	chan child_HasMethod1463 = [1] of {int};
	chan child_RegisterService1392 = [1] of {int};
	chan child_HasMethod1461 = [1] of {int};
	chan child_RegisterService1390 = [1] of {int};
	Mutexdef s_services_mutex;
	run mutexMonitor(s_services_mutex);
	run RegisterService139(s_services_mutex,child_RegisterService1390);
	child_RegisterService1390?0;
	run HasMethod146(s_services_mutex,child_HasMethod1461);
	child_HasMethod1461?0;
	run RegisterService139(s_services_mutex,child_RegisterService1392);
	child_RegisterService1392?0;
	run HasMethod146(s_services_mutex,child_HasMethod1463);
	child_HasMethod1463?0;
	run RegisterService139(s_services_mutex,child_RegisterService1394);
	child_RegisterService1394?0;
	stop_process: skip;
	child!0
}
proctype RegisterService139(Mutexdef s_services_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_register570 = [1] of {int};
	run register57(s_services_mutex,child_register570);
	child_register570?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype register57(Mutexdef m_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	m_mutex.Lock!false;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	goto stop_process;
	stop_process: skip;
		m_mutex.Unlock!false;
	child!0
}
proctype HasMethod146(Mutexdef s_services_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_get1341 = [1] of {int};
	run get134(s_services_mutex,child_get1341);
	child_get1341?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype get134(Mutexdef m_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	m_mutex.Lock!false;
	m_mutex.Unlock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

