
// https://github.com/fyne-io/fyne/blob/master/shortcut_test.go#L34
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestShortcutHandler_HandleShortcut340 = [1] of {int};
	run TestShortcutHandler_HandleShortcut34(child_TestShortcutHandler_HandleShortcut340)
stop_process:skip
}

proctype TestShortcutHandler_HandleShortcut34(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_TypedShortcut155 = [1] of {int};
	chan child_TypedShortcut154 = [1] of {int};
	chan child_TypedShortcut153 = [1] of {int};
	chan child_AddShortcut242 = [1] of {int};
	chan child_AddShortcut241 = [1] of {int};
	chan child_AddShortcut240 = [1] of {int};
	Mutexdef handle_mu;
	run mutexMonitor(handle_mu);
	run AddShortcut24(handle_mu,child_AddShortcut240);
	child_AddShortcut240?0;
	run AddShortcut24(handle_mu,child_AddShortcut241);
	child_AddShortcut241?0;
	run AddShortcut24(handle_mu,child_AddShortcut242);
	child_AddShortcut242?0;
	run TypedShortcut15(handle_mu,child_TypedShortcut153);
	child_TypedShortcut153?0;
	run TypedShortcut15(handle_mu,child_TypedShortcut154);
	child_TypedShortcut154?0;
	run TypedShortcut15(handle_mu,child_TypedShortcut155);
	child_TypedShortcut155?0;
	stop_process: skip;
	child!0
}
proctype AddShortcut24(Mutexdef sh_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	sh_mu.Lock!false;
	stop_process: skip;
		sh_mu.Unlock!false;
	child!0
}
proctype TypedShortcut15(Mutexdef sh_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
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

