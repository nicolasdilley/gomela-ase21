
// https://github.com/pingcap/tidb/blob/master/executor/set.go#L53
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Next530 = [1] of {int};
	run Next53(child_Next530)
stop_process:skip
}

proctype Next53(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef sessionVars_SequenceState_mu;
	Mutexdef sessionVars_StmtCtx_digestMemo_m;
	Mutexdef sessionVars_StmtCtx_RuntimeStatsColl_mu;
	Mutexdef sessionVars_StmtCtx_DiskTracker_parMu;
	Mutexdef sessionVars_StmtCtx_DiskTracker_actionMu;
	Mutexdef sessionVars_StmtCtx_DiskTracker_mu;
	Mutexdef sessionVars_StmtCtx_MemTracker_parMu;
	Mutexdef sessionVars_StmtCtx_MemTracker_actionMu;
	Mutexdef sessionVars_StmtCtx_MemTracker_mu;
	Mutexdef sessionVars_StmtCtx_mu_LockKeysDetail_Mu;
	Mutexdef sessionVars_StmtCtx_mu_CommitDetail_Mu;
	Mutexdef sessionVars_StmtCtx_mu_execDetails_LockKeysDetail_Mu;
	Mutexdef sessionVars_StmtCtx_mu_execDetails_CommitDetail_Mu;
	Mutexdef sessionVars_BinlogClient_Security_mutex;
	Mutexdef sessionVars_BinlogClient_EtcdRegistry_client_client_mu;
	Mutexdef sessionVars_BinlogClient_EtcdRegistry_client_client_resolverGroup_mu;
	Mutexdef sessionVars_BinlogClient_EtcdRegistry_client_client_cfg_TLS_mutex;
	Mutexdef sessionVars_BinlogClient_EtcdRegistry_client_client_conn_firstResolveEvent_o_m;
	Mutexdef sessionVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_mu;
	Mutexdef sessionVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_done_o_m;
	Mutexdef sessionVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_scBuffer_mu;
	Mutexdef sessionVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_balancerMu;
	Mutexdef sessionVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_pollingMu;
	Mutexdef sessionVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_done_o_m;
	Mutexdef sessionVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_resolverMu;
	Mutexdef sessionVars_BinlogClient_EtcdRegistry_client_client_conn_mu;
	Mutexdef sessionVars_BinlogClient_EtcdRegistry_client_client_conn_blockingpicker_mu;
	Mutexdef sessionVars_BinlogClient_EtcdRegistry_client_client_conn_csMgr_mu;
	Wgdef sessionVars_BinlogClient_wg;
	Mutexdef sessionVars_TxnCtx_tdmLock;
	Mutexdef sessionVars_UsersLock;
	int e_vars = -2;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(sessionVars_UsersLock);
	run mutexMonitor(sessionVars_TxnCtx_tdmLock);
	run wgMonitor(sessionVars_BinlogClient_wg);
	run mutexMonitor(sessionVars_BinlogClient_EtcdRegistry_client_client_conn_csMgr_mu);
	run mutexMonitor(sessionVars_BinlogClient_EtcdRegistry_client_client_conn_blockingpicker_mu);
	run mutexMonitor(sessionVars_BinlogClient_EtcdRegistry_client_client_conn_mu);
	run mutexMonitor(sessionVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_resolverMu);
	run mutexMonitor(sessionVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_done_o_m);
	run mutexMonitor(sessionVars_BinlogClient_EtcdRegistry_client_client_conn_resolverWrapper_pollingMu);
	run mutexMonitor(sessionVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_balancerMu);
	run mutexMonitor(sessionVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(sessionVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_done_o_m);
	run mutexMonitor(sessionVars_BinlogClient_EtcdRegistry_client_client_conn_balancerWrapper_mu);
	run mutexMonitor(sessionVars_BinlogClient_EtcdRegistry_client_client_conn_firstResolveEvent_o_m);
	run mutexMonitor(sessionVars_BinlogClient_EtcdRegistry_client_client_cfg_TLS_mutex);
	run mutexMonitor(sessionVars_BinlogClient_EtcdRegistry_client_client_resolverGroup_mu);
	run mutexMonitor(sessionVars_BinlogClient_EtcdRegistry_client_client_mu);
	run mutexMonitor(sessionVars_BinlogClient_Security_mutex);
	run mutexMonitor(sessionVars_StmtCtx_mu_execDetails_CommitDetail_Mu);
	run mutexMonitor(sessionVars_StmtCtx_mu_execDetails_LockKeysDetail_Mu);
	run mutexMonitor(sessionVars_StmtCtx_mu_CommitDetail_Mu);
	run mutexMonitor(sessionVars_StmtCtx_mu_LockKeysDetail_Mu);
	run mutexMonitor(sessionVars_StmtCtx_MemTracker_mu);
	run mutexMonitor(sessionVars_StmtCtx_MemTracker_actionMu);
	run mutexMonitor(sessionVars_StmtCtx_MemTracker_parMu);
	run mutexMonitor(sessionVars_StmtCtx_DiskTracker_mu);
	run mutexMonitor(sessionVars_StmtCtx_DiskTracker_actionMu);
	run mutexMonitor(sessionVars_StmtCtx_DiskTracker_parMu);
	run mutexMonitor(sessionVars_StmtCtx_RuntimeStatsColl_mu);
	run mutexMonitor(sessionVars_StmtCtx_digestMemo_m);
	run mutexMonitor(sessionVars_SequenceState_mu);
	

	if
	:: e_vars-1 != -3 -> 
				for(i : 0.. e_vars-1) {
			for10: skip;
			

			if
			:: true -> 
				

				if
				:: true -> 
					

					if
					:: true -> 
						goto stop_process
					:: true;
					fi;
					goto for10_end
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
				goto for10_end
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				sessionVars_UsersLock.Lock!false;
				sessionVars_UsersLock.Unlock!false;
				goto for10_end
			:: true;
			fi;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for13: skip;
			

			if
			:: true -> 
				

				if
				:: true -> 
					

					if
					:: true -> 
						goto stop_process
					:: true;
					fi;
					goto for13_end
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
				goto for13_end
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				sessionVars_UsersLock.Lock!false;
				sessionVars_UsersLock.Unlock!false;
				goto for13_end
			:: true;
			fi;
			for13_end: skip
		:: true -> 
			break
		od;
		for13_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

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

