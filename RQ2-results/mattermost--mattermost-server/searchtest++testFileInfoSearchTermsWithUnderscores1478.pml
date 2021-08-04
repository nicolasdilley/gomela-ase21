
// https://github.com/mattermost/mattermost-server/blob/master/store/searchtest/file_info_layer.go#L1478
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_testFileInfoSearchTermsWithUnderscores14780 = [1] of {int};
	run testFileInfoSearchTermsWithUnderscores1478(child_testFileInfoSearchTermsWithUnderscores14780)
stop_process:skip
}

proctype testFileInfoSearchTermsWithUnderscores1478(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef post_propsMu;
	run mutexMonitor(post_propsMu);
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
