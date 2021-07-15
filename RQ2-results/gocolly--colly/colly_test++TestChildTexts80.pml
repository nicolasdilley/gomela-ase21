
// https://github.com/gocolly/colly/blob/master/xmlelement_test.go#L80
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
	chan child_TestChildTexts800 = [1] of {int};
	run TestChildTexts80(child_TestChildTexts800)
stop_process:skip
}

proctype TestChildTexts80(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewXMLElementFromHTMLNode430 = [1] of {int};
	Mutexdef xmlElem_Response_Request_collector_lock;
	Wgdef xmlElem_Response_Request_collector_wg;
	Mutexdef xmlElem_Response_Request_collector_backend_lock;
	Mutexdef xmlElem_Response_Request_Ctx_lock;
	Mutexdef xmlElem_Response_Ctx_lock;
	Mutexdef xmlElem_Request_collector_lock;
	Wgdef xmlElem_Request_collector_wg;
	Mutexdef xmlElem_Request_collector_backend_lock;
	Mutexdef xmlElem_Request_Ctx_lock;
	Mutexdef resp_Request_collector_lock;
	Wgdef resp_Request_collector_wg;
	Mutexdef resp_Request_collector_backend_lock;
	Mutexdef resp_Request_Ctx_lock;
	Mutexdef resp_Ctx_lock;
	run mutexMonitor(resp_Ctx_lock);
	run mutexMonitor(resp_Request_Ctx_lock);
	run mutexMonitor(resp_Request_collector_backend_lock);
	run wgMonitor(resp_Request_collector_wg);
	run mutexMonitor(resp_Request_collector_lock);
	run mutexMonitor(xmlElem_Request_Ctx_lock);
	run mutexMonitor(xmlElem_Request_collector_backend_lock);
	run wgMonitor(xmlElem_Request_collector_wg);
	run mutexMonitor(xmlElem_Request_collector_lock);
	run mutexMonitor(xmlElem_Response_Ctx_lock);
	run mutexMonitor(xmlElem_Response_Request_Ctx_lock);
	run mutexMonitor(xmlElem_Response_Request_collector_backend_lock);
	run wgMonitor(xmlElem_Response_Request_collector_wg);
	run mutexMonitor(xmlElem_Response_Request_collector_lock);
	run NewXMLElementFromHTMLNode43(resp_Request_collector_wg,resp_Ctx_lock,resp_Request_Ctx_lock,resp_Request_collector_backend_lock,resp_Request_collector_lock,child_NewXMLElementFromHTMLNode430);
	child_NewXMLElementFromHTMLNode430?0;
	stop_process: skip;
	child!0
}
proctype NewXMLElementFromHTMLNode43(Wgdef resp_Request_collector_wg;Mutexdef resp_Ctx_lock;Mutexdef resp_Request_Ctx_lock;Mutexdef resp_Request_collector_backend_lock;Mutexdef resp_Request_collector_lock;chan child) {
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

