
// https://github.com/fyne-io/fyne/blob/master/internal/driver/gomobile/canvas_test.go#L57
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCanvas_PixelCoordinateAtPosition570 = [1] of {int};
	run TestCanvas_PixelCoordinateAtPosition57(child_TestCanvas_PixelCoordinateAtPosition570)
stop_process:skip
}

proctype TestCanvas_PixelCoordinateAtPosition57(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_PixelCoordinateForPosition1520 = [1] of {int};
	Mutexdef c_shortcut_mu;
	Mutexdef c_overlays_propertyLock;
	run mutexMonitor(c_overlays_propertyLock);
	run mutexMonitor(c_shortcut_mu);
	run PixelCoordinateForPosition152(c_overlays_propertyLock,c_shortcut_mu,child_PixelCoordinateForPosition1520);
	child_PixelCoordinateForPosition1520?0;
	stop_process: skip;
	child!0
}
proctype PixelCoordinateForPosition152(Mutexdef c_overlays_propertyLock;Mutexdef c_shortcut_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

