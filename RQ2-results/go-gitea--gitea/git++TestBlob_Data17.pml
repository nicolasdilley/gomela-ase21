
// https://github.com/go-gitea/gitea/blob/master/modules/git/blob_test.go#L17
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBlob_Data170 = [1] of {int};
	run TestBlob_Data17(child_TestBlob_Data170)
stop_process:skip
}

proctype TestBlob_Data17(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close390 = [1] of {int};
	chan child_GetBlob81 = [1] of {int};
	Mutexdef repo_tagCache_lock;
	run mutexMonitor(repo_tagCache_lock);
	run GetBlob8(repo_tagCache_lock,child_GetBlob81);
	child_GetBlob81?0;
	stop_process: skip;
		run Close39(repo_tagCache_lock,child_Close390);
	child_Close390?0;
	child!0
}
proctype Close39(Mutexdef repo_tagCache_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype GetBlob8(Mutexdef repo_tagCache_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getBlob91 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run getBlob9(repo_tagCache_lock,child_getBlob91);
	child_getBlob91?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getBlob9(Mutexdef repo_tagCache_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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
