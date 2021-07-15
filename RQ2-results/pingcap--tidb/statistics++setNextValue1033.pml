
// https://github.com/pingcap/tidb/blob/master/statistics/feedback.go#L1033
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_setNextValue10330 = [1] of {int};
	run setNextValue1033(child_setNextValue10330)
stop_process:skip
}

proctype setNextValue1033(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef sc_digestMemo_m;
	Mutexdef sc_RuntimeStatsColl_mu;
	Mutexdef sc_DiskTracker_parMu;
	Mutexdef sc_DiskTracker_actionMu;
	Mutexdef sc_DiskTracker_mu;
	Mutexdef sc_MemTracker_parMu;
	Mutexdef sc_MemTracker_actionMu;
	Mutexdef sc_MemTracker_mu;
	Mutexdef sc_mu_LockKeysDetail_Mu;
	Mutexdef sc_mu_CommitDetail_Mu;
	Mutexdef sc_mu_execDetails_LockKeysDetail_Mu;
	Mutexdef sc_mu_execDetails_CommitDetail_Mu;
	

	if
	:: true;
	:: true;
	:: true;
	:: true;
	:: true -> 
		run mutexMonitor(sc_mu_execDetails_CommitDetail_Mu);
		run mutexMonitor(sc_mu_execDetails_LockKeysDetail_Mu);
		run mutexMonitor(sc_mu_CommitDetail_Mu);
		run mutexMonitor(sc_mu_LockKeysDetail_Mu);
		run mutexMonitor(sc_MemTracker_mu);
		run mutexMonitor(sc_MemTracker_actionMu);
		run mutexMonitor(sc_MemTracker_parMu);
		run mutexMonitor(sc_DiskTracker_mu);
		run mutexMonitor(sc_DiskTracker_actionMu);
		run mutexMonitor(sc_DiskTracker_parMu);
		run mutexMonitor(sc_RuntimeStatsColl_mu);
		run mutexMonitor(sc_digestMemo_m)
	fi;
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

