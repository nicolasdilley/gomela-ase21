
// https://github.com/hashicorp/terraform/blob/master/plugin/grpc_provider_test.go#L684
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
	chan child_TestGRPCProvider_ReadDataSourceJSON6840 = [1] of {int};
	run TestGRPCProvider_ReadDataSourceJSON684(child_TestGRPCProvider_ReadDataSourceJSON6840)
stop_process:skip
}

proctype TestGRPCProvider_ReadDataSourceJSON684(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ReadDataSource5380 = [1] of {int};
	Mutexdef p_mu;
	Wgdef p_TestServer_serveWG;
	Mutexdef p_TestServer_channelzRemoveOnce_m;
	Mutexdef p_TestServer_done_o_m;
	Mutexdef p_TestServer_quit_o_m;
	Mutexdef p_TestServer_mu;
	Wgdef p_PluginClient_stderrWaitGroup;
	Wgdef p_PluginClient_clientWaitGroup;
	Mutexdef p_PluginClient_process_sigMu;
	Mutexdef p_PluginClient_l;
	Mutexdef p_PluginClient_config_TLSConfig_mutex;
	Mutexdef p_PluginClient_config_Cmd_Process_sigMu;
	Mutexdef client_ctrl_mu;
	run mutexMonitor(client_ctrl_mu);
	run mutexMonitor(p_PluginClient_config_Cmd_Process_sigMu);
	run mutexMonitor(p_PluginClient_config_TLSConfig_mutex);
	run mutexMonitor(p_PluginClient_l);
	run mutexMonitor(p_PluginClient_process_sigMu);
	run wgMonitor(p_PluginClient_clientWaitGroup);
	run wgMonitor(p_PluginClient_stderrWaitGroup);
	run mutexMonitor(p_TestServer_mu);
	run mutexMonitor(p_TestServer_quit_o_m);
	run mutexMonitor(p_TestServer_done_o_m);
	run mutexMonitor(p_TestServer_channelzRemoveOnce_m);
	run wgMonitor(p_TestServer_serveWG);
	run mutexMonitor(p_mu);
	run ReadDataSource538(p_PluginClient_clientWaitGroup,p_PluginClient_stderrWaitGroup,p_TestServer_serveWG,p_PluginClient_config_Cmd_Process_sigMu,p_PluginClient_config_TLSConfig_mutex,p_PluginClient_l,p_PluginClient_process_sigMu,p_TestServer_mu,p_TestServer_quit_o_m,p_TestServer_done_o_m,p_TestServer_channelzRemoveOnce_m,p_mu,child_ReadDataSource5380);
	child_ReadDataSource5380?0;
	stop_process: skip;
	child!0
}
proctype ReadDataSource538(Wgdef p_PluginClient_clientWaitGroup;Wgdef p_PluginClient_stderrWaitGroup;Wgdef p_TestServer_serveWG;Mutexdef p_PluginClient_config_Cmd_Process_sigMu;Mutexdef p_PluginClient_config_TLSConfig_mutex;Mutexdef p_PluginClient_l;Mutexdef p_PluginClient_process_sigMu;Mutexdef p_TestServer_mu;Mutexdef p_TestServer_quit_o_m;Mutexdef p_TestServer_done_o_m;Mutexdef p_TestServer_channelzRemoveOnce_m;Mutexdef p_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_decodeDynamicValue6062 = [1] of {int};
	Mutexdef protoResp_State_state_atomicMessageInfo_initMu;
	Mutexdef protoResp_state_atomicMessageInfo_initMu;
	Mutexdef protoReq_ProviderMeta_state_atomicMessageInfo_initMu;
	Mutexdef protoReq_Config_state_atomicMessageInfo_initMu;
	Mutexdef protoReq_state_atomicMessageInfo_initMu;
	chan child_getProviderMetaSchema1131 = [1] of {int};
	chan child_getDatasourceSchema1020 = [1] of {int};
	run getDatasourceSchema102(p_PluginClient_clientWaitGroup,p_PluginClient_stderrWaitGroup,p_TestServer_serveWG,p_PluginClient_config_Cmd_Process_sigMu,p_PluginClient_config_TLSConfig_mutex,p_PluginClient_l,p_PluginClient_process_sigMu,p_TestServer_mu,p_TestServer_quit_o_m,p_TestServer_done_o_m,p_TestServer_channelzRemoveOnce_m,p_mu,child_getDatasourceSchema1020);
	child_getDatasourceSchema1020?0;
	run getProviderMetaSchema113(p_PluginClient_clientWaitGroup,p_PluginClient_stderrWaitGroup,p_TestServer_serveWG,p_PluginClient_config_Cmd_Process_sigMu,p_PluginClient_config_TLSConfig_mutex,p_PluginClient_l,p_PluginClient_process_sigMu,p_TestServer_mu,p_TestServer_quit_o_m,p_TestServer_done_o_m,p_TestServer_channelzRemoveOnce_m,p_mu,child_getProviderMetaSchema1131);
	child_getProviderMetaSchema1131?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(protoReq_state_atomicMessageInfo_initMu);
	run mutexMonitor(protoReq_Config_state_atomicMessageInfo_initMu);
	run mutexMonitor(protoReq_ProviderMeta_state_atomicMessageInfo_initMu);
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	run mutexMonitor(protoResp_state_atomicMessageInfo_initMu);
	run mutexMonitor(protoResp_State_state_atomicMessageInfo_initMu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run decodeDynamicValue606(protoResp_State_state_atomicMessageInfo_initMu,child_decodeDynamicValue6062);
	child_decodeDynamicValue6062?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getDatasourceSchema102(Wgdef p_PluginClient_clientWaitGroup;Wgdef p_PluginClient_stderrWaitGroup;Wgdef p_TestServer_serveWG;Mutexdef p_PluginClient_config_Cmd_Process_sigMu;Mutexdef p_PluginClient_config_TLSConfig_mutex;Mutexdef p_PluginClient_l;Mutexdef p_PluginClient_process_sigMu;Mutexdef p_TestServer_mu;Mutexdef p_TestServer_quit_o_m;Mutexdef p_TestServer_done_o_m;Mutexdef p_TestServer_channelzRemoveOnce_m;Mutexdef p_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getSchema690 = [1] of {int};
	run getSchema69(p_PluginClient_clientWaitGroup,p_PluginClient_stderrWaitGroup,p_TestServer_serveWG,p_PluginClient_config_Cmd_Process_sigMu,p_PluginClient_config_TLSConfig_mutex,p_PluginClient_l,p_PluginClient_process_sigMu,p_TestServer_mu,p_TestServer_quit_o_m,p_TestServer_done_o_m,p_TestServer_channelzRemoveOnce_m,p_mu,child_getSchema690);
	child_getSchema690?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getSchema69(Wgdef p_PluginClient_clientWaitGroup;Wgdef p_PluginClient_stderrWaitGroup;Wgdef p_TestServer_serveWG;Mutexdef p_PluginClient_config_Cmd_Process_sigMu;Mutexdef p_PluginClient_config_TLSConfig_mutex;Mutexdef p_PluginClient_l;Mutexdef p_PluginClient_process_sigMu;Mutexdef p_TestServer_mu;Mutexdef p_TestServer_quit_o_m;Mutexdef p_TestServer_done_o_m;Mutexdef p_TestServer_channelzRemoveOnce_m;Mutexdef p_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetProviderSchema1180 = [1] of {int};
	p_mu.Lock!false;
	

	if
	:: true -> 
		p_mu.Unlock!false;
		goto stop_process
	:: true;
	fi;
	p_mu.Unlock!false;
	run GetProviderSchema118(p_PluginClient_clientWaitGroup,p_PluginClient_stderrWaitGroup,p_TestServer_serveWG,p_PluginClient_config_Cmd_Process_sigMu,p_PluginClient_config_TLSConfig_mutex,p_PluginClient_l,p_PluginClient_process_sigMu,p_TestServer_mu,p_TestServer_quit_o_m,p_TestServer_done_o_m,p_TestServer_channelzRemoveOnce_m,p_mu,child_GetProviderSchema1180);
	child_GetProviderSchema1180?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype GetProviderSchema118(Wgdef p_PluginClient_clientWaitGroup;Wgdef p_PluginClient_stderrWaitGroup;Wgdef p_TestServer_serveWG;Mutexdef p_PluginClient_config_Cmd_Process_sigMu;Mutexdef p_PluginClient_config_TLSConfig_mutex;Mutexdef p_PluginClient_l;Mutexdef p_PluginClient_process_sigMu;Mutexdef p_TestServer_mu;Mutexdef p_TestServer_quit_o_m;Mutexdef p_TestServer_done_o_m;Mutexdef p_TestServer_channelzRemoveOnce_m;Mutexdef p_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ProtoToProviderSchema951 = [1] of {int};
	chan child_ProtoToProviderSchema950 = [1] of {int};
	Mutexdef protoResp_ProviderMeta_Block_state_atomicMessageInfo_initMu;
	Mutexdef protoResp_ProviderMeta_state_atomicMessageInfo_initMu;
	Mutexdef protoResp_Provider_Block_state_atomicMessageInfo_initMu;
	Mutexdef protoResp_Provider_state_atomicMessageInfo_initMu;
	Mutexdef protoResp_state_atomicMessageInfo_initMu;
	p_mu.Lock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(protoResp_state_atomicMessageInfo_initMu);
	run mutexMonitor(protoResp_Provider_state_atomicMessageInfo_initMu);
	run mutexMonitor(protoResp_Provider_Block_state_atomicMessageInfo_initMu);
	run mutexMonitor(protoResp_ProviderMeta_state_atomicMessageInfo_initMu);
	run mutexMonitor(protoResp_ProviderMeta_Block_state_atomicMessageInfo_initMu);
	

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
	run ProtoToProviderSchema95(protoResp_Provider_state_atomicMessageInfo_initMu,protoResp_Provider_Block_state_atomicMessageInfo_initMu,child_ProtoToProviderSchema950);
	child_ProtoToProviderSchema950?0;
	

	if
	:: true -> 
		run ProtoToProviderSchema95(protoResp_ProviderMeta_state_atomicMessageInfo_initMu,protoResp_ProviderMeta_Block_state_atomicMessageInfo_initMu,child_ProtoToProviderSchema951);
		child_ProtoToProviderSchema951?0
	fi;
	goto stop_process;
	stop_process: skip;
		p_mu.Unlock!false;
	child!0
}
proctype ProtoToProviderSchema95(Mutexdef s_state_atomicMessageInfo_initMu;Mutexdef s_Block_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getProviderMetaSchema113(Wgdef p_PluginClient_clientWaitGroup;Wgdef p_PluginClient_stderrWaitGroup;Wgdef p_TestServer_serveWG;Mutexdef p_PluginClient_config_Cmd_Process_sigMu;Mutexdef p_PluginClient_config_TLSConfig_mutex;Mutexdef p_PluginClient_l;Mutexdef p_PluginClient_process_sigMu;Mutexdef p_TestServer_mu;Mutexdef p_TestServer_quit_o_m;Mutexdef p_TestServer_done_o_m;Mutexdef p_TestServer_channelzRemoveOnce_m;Mutexdef p_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getSchema691 = [1] of {int};
	run getSchema69(p_PluginClient_clientWaitGroup,p_PluginClient_stderrWaitGroup,p_TestServer_serveWG,p_PluginClient_config_Cmd_Process_sigMu,p_PluginClient_config_TLSConfig_mutex,p_PluginClient_l,p_PluginClient_process_sigMu,p_TestServer_mu,p_TestServer_quit_o_m,p_TestServer_done_o_m,p_TestServer_channelzRemoveOnce_m,p_mu,child_getSchema691);
	child_getSchema691?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype decodeDynamicValue606(Mutexdef v_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true;
	:: true;
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

