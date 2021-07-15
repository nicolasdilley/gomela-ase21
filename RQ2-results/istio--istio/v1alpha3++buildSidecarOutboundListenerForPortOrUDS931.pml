
// https://github.com/istio/istio/blob/master/pilot/pkg/networking/core/v1alpha3/listener.go#L931
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_buildSidecarOutboundListenerForPortOrUDS9310 = [1] of {int};
	run buildSidecarOutboundListenerForPortOrUDS931(child_buildSidecarOutboundListenerForPortOrUDS9310)
stop_process:skip
}

proctype buildSidecarOutboundListenerForPortOrUDS931(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_OnOutboundListener23480 = [1] of {int};
	chan child_OnOutboundListener23481 = [1] of {int};
	Mutexdef pluginParams_Push_initializeMutex;
	Mutexdef pluginParams_Push_networksMu;
	Mutexdef pluginParams_Push_JwtKeyResolver_keyEntries_mu;
	Mutexdef pluginParams_Push_proxyStatusMutex;
	Mutexdef pluginParams_ServiceInstance_Endpoint_EnvoyEndpoint_LoadBalancingWeight_state_atomicMessageInfo_initMu;
	Mutexdef pluginParams_ServiceInstance_Endpoint_EnvoyEndpoint_Metadata_state_atomicMessageInfo_initMu;
	Mutexdef pluginParams_ServiceInstance_Endpoint_EnvoyEndpoint_state_atomicMessageInfo_initMu;
	Mutexdef pluginParams_ServiceInstance_Service_Mutex;
	Mutexdef pluginParams_Node_Locality_state_atomicMessageInfo_initMu;
	Mutexdef l_BindToPort_state_atomicMessageInfo_initMu;
	Mutexdef l_TcpBacklogSize_state_atomicMessageInfo_initMu;
	Mutexdef l_ConnectionBalanceConfig_state_atomicMessageInfo_initMu;
	Mutexdef l_ApiListener_ApiListener_state_atomicMessageInfo_initMu;
	Mutexdef l_ApiListener_state_atomicMessageInfo_initMu;
	Mutexdef l_UdpListenerConfig_QuicOptions_Enabled_DefaultValue_state_atomicMessageInfo_initMu;
	Mutexdef l_UdpListenerConfig_QuicOptions_Enabled_state_atomicMessageInfo_initMu;
	Mutexdef l_UdpListenerConfig_QuicOptions_CryptoHandshakeTimeout_state_atomicMessageInfo_initMu;
	Mutexdef l_UdpListenerConfig_QuicOptions_IdleTimeout_state_atomicMessageInfo_initMu;
	Mutexdef l_UdpListenerConfig_QuicOptions_QuicProtocolOptions_MaxConcurrentStreams_state_atomicMessageInfo_initMu;
	Mutexdef l_UdpListenerConfig_QuicOptions_QuicProtocolOptions_state_atomicMessageInfo_initMu;
	Mutexdef l_UdpListenerConfig_QuicOptions_state_atomicMessageInfo_initMu;
	Mutexdef l_UdpListenerConfig_DownstreamSocketConfig_PreferGro_state_atomicMessageInfo_initMu;
	Mutexdef l_UdpListenerConfig_DownstreamSocketConfig_MaxRxDatagramSize_state_atomicMessageInfo_initMu;
	Mutexdef l_UdpListenerConfig_DownstreamSocketConfig_state_atomicMessageInfo_initMu;
	Mutexdef l_UdpListenerConfig_state_atomicMessageInfo_initMu;
	Mutexdef l_TcpFastOpenQueueLength_state_atomicMessageInfo_initMu;
	Mutexdef l_Freebind_state_atomicMessageInfo_initMu;
	Mutexdef l_Transparent_state_atomicMessageInfo_initMu;
	Mutexdef l_ListenerFiltersTimeout_state_atomicMessageInfo_initMu;
	Mutexdef l_DeprecatedV1_BindToPort_state_atomicMessageInfo_initMu;
	Mutexdef l_DeprecatedV1_state_atomicMessageInfo_initMu;
	Mutexdef l_Metadata_state_atomicMessageInfo_initMu;
	Mutexdef l_PerConnectionBufferLimitBytes_state_atomicMessageInfo_initMu;
	Mutexdef l_DefaultFilterChain_HiddenEnvoyDeprecatedTlsContext_SessionTimeout_state_atomicMessageInfo_initMu;
	Mutexdef l_DefaultFilterChain_HiddenEnvoyDeprecatedTlsContext_RequireSni_state_atomicMessageInfo_initMu;
	Mutexdef l_DefaultFilterChain_HiddenEnvoyDeprecatedTlsContext_RequireClientCertificate_state_atomicMessageInfo_initMu;
	Mutexdef l_DefaultFilterChain_HiddenEnvoyDeprecatedTlsContext_CommonTlsContext_CustomHandshaker_TypedConfig_state_atomicMessageInfo_initMu;
	Mutexdef l_DefaultFilterChain_HiddenEnvoyDeprecatedTlsContext_CommonTlsContext_CustomHandshaker_state_atomicMessageInfo_initMu;
	Mutexdef l_DefaultFilterChain_HiddenEnvoyDeprecatedTlsContext_CommonTlsContext_TlsCertificateCertificateProviderInstance_state_atomicMessageInfo_initMu;
	Mutexdef l_DefaultFilterChain_HiddenEnvoyDeprecatedTlsContext_CommonTlsContext_TlsCertificateCertificateProvider_state_atomicMessageInfo_initMu;
	Mutexdef l_DefaultFilterChain_HiddenEnvoyDeprecatedTlsContext_CommonTlsContext_TlsParams_state_atomicMessageInfo_initMu;
	Mutexdef l_DefaultFilterChain_HiddenEnvoyDeprecatedTlsContext_CommonTlsContext_state_atomicMessageInfo_initMu;
	Mutexdef l_DefaultFilterChain_HiddenEnvoyDeprecatedTlsContext_state_atomicMessageInfo_initMu;
	Mutexdef l_DefaultFilterChain_OnDemandConfiguration_RebuildTimeout_state_atomicMessageInfo_initMu;
	Mutexdef l_DefaultFilterChain_OnDemandConfiguration_state_atomicMessageInfo_initMu;
	Mutexdef l_DefaultFilterChain_TransportSocketConnectTimeout_state_atomicMessageInfo_initMu;
	Mutexdef l_DefaultFilterChain_TransportSocket_state_atomicMessageInfo_initMu;
	Mutexdef l_DefaultFilterChain_Metadata_state_atomicMessageInfo_initMu;
	Mutexdef l_DefaultFilterChain_UseProxyProto_state_atomicMessageInfo_initMu;
	Mutexdef l_DefaultFilterChain_FilterChainMatch_SuffixLen_state_atomicMessageInfo_initMu;
	Mutexdef l_DefaultFilterChain_FilterChainMatch_DestinationPort_state_atomicMessageInfo_initMu;
	Mutexdef l_DefaultFilterChain_FilterChainMatch_state_atomicMessageInfo_initMu;
	Mutexdef l_DefaultFilterChain_state_atomicMessageInfo_initMu;
	Mutexdef l_UseOriginalDst_state_atomicMessageInfo_initMu;
	Mutexdef l_Address_state_atomicMessageInfo_initMu;
	Mutexdef l_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_BindToPort_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_TcpBacklogSize_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_ConnectionBalanceConfig_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_ApiListener_ApiListener_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_ApiListener_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_UdpListenerConfig_QuicOptions_Enabled_DefaultValue_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_UdpListenerConfig_QuicOptions_Enabled_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_UdpListenerConfig_QuicOptions_CryptoHandshakeTimeout_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_UdpListenerConfig_QuicOptions_IdleTimeout_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_UdpListenerConfig_QuicOptions_QuicProtocolOptions_MaxConcurrentStreams_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_UdpListenerConfig_QuicOptions_QuicProtocolOptions_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_UdpListenerConfig_QuicOptions_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_UdpListenerConfig_DownstreamSocketConfig_PreferGro_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_UdpListenerConfig_DownstreamSocketConfig_MaxRxDatagramSize_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_UdpListenerConfig_DownstreamSocketConfig_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_UdpListenerConfig_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_TcpFastOpenQueueLength_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_Freebind_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_Transparent_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_ListenerFiltersTimeout_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_DeprecatedV1_BindToPort_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_DeprecatedV1_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_Metadata_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_PerConnectionBufferLimitBytes_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_DefaultFilterChain_HiddenEnvoyDeprecatedTlsContext_SessionTimeout_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_DefaultFilterChain_HiddenEnvoyDeprecatedTlsContext_RequireSni_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_DefaultFilterChain_HiddenEnvoyDeprecatedTlsContext_RequireClientCertificate_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_DefaultFilterChain_HiddenEnvoyDeprecatedTlsContext_CommonTlsContext_CustomHandshaker_TypedConfig_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_DefaultFilterChain_HiddenEnvoyDeprecatedTlsContext_CommonTlsContext_CustomHandshaker_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_DefaultFilterChain_HiddenEnvoyDeprecatedTlsContext_CommonTlsContext_TlsCertificateCertificateProviderInstance_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_DefaultFilterChain_HiddenEnvoyDeprecatedTlsContext_CommonTlsContext_TlsCertificateCertificateProvider_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_DefaultFilterChain_HiddenEnvoyDeprecatedTlsContext_CommonTlsContext_TlsParams_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_DefaultFilterChain_HiddenEnvoyDeprecatedTlsContext_CommonTlsContext_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_DefaultFilterChain_HiddenEnvoyDeprecatedTlsContext_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_DefaultFilterChain_OnDemandConfiguration_RebuildTimeout_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_DefaultFilterChain_OnDemandConfiguration_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_DefaultFilterChain_TransportSocketConnectTimeout_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_DefaultFilterChain_TransportSocket_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_DefaultFilterChain_Metadata_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_DefaultFilterChain_UseProxyProto_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_DefaultFilterChain_FilterChainMatch_SuffixLen_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_DefaultFilterChain_FilterChainMatch_DestinationPort_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_DefaultFilterChain_FilterChainMatch_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_DefaultFilterChain_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_UseOriginalDst_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_Address_state_atomicMessageInfo_initMu;
	Mutexdef currentListenerEntry_listener_state_atomicMessageInfo_initMu;
	int configgen_Plugins=3;
	run mutexMonitor(currentListenerEntry_listener_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_Address_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_UseOriginalDst_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_DefaultFilterChain_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_DefaultFilterChain_FilterChainMatch_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_DefaultFilterChain_FilterChainMatch_DestinationPort_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_DefaultFilterChain_FilterChainMatch_SuffixLen_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_DefaultFilterChain_UseProxyProto_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_DefaultFilterChain_Metadata_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_DefaultFilterChain_TransportSocket_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_DefaultFilterChain_TransportSocketConnectTimeout_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_DefaultFilterChain_OnDemandConfiguration_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_DefaultFilterChain_OnDemandConfiguration_RebuildTimeout_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_DefaultFilterChain_HiddenEnvoyDeprecatedTlsContext_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_DefaultFilterChain_HiddenEnvoyDeprecatedTlsContext_CommonTlsContext_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_DefaultFilterChain_HiddenEnvoyDeprecatedTlsContext_CommonTlsContext_TlsParams_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_DefaultFilterChain_HiddenEnvoyDeprecatedTlsContext_CommonTlsContext_TlsCertificateCertificateProvider_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_DefaultFilterChain_HiddenEnvoyDeprecatedTlsContext_CommonTlsContext_TlsCertificateCertificateProviderInstance_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_DefaultFilterChain_HiddenEnvoyDeprecatedTlsContext_CommonTlsContext_CustomHandshaker_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_DefaultFilterChain_HiddenEnvoyDeprecatedTlsContext_CommonTlsContext_CustomHandshaker_TypedConfig_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_DefaultFilterChain_HiddenEnvoyDeprecatedTlsContext_RequireClientCertificate_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_DefaultFilterChain_HiddenEnvoyDeprecatedTlsContext_RequireSni_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_DefaultFilterChain_HiddenEnvoyDeprecatedTlsContext_SessionTimeout_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_PerConnectionBufferLimitBytes_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_Metadata_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_DeprecatedV1_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_DeprecatedV1_BindToPort_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_ListenerFiltersTimeout_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_Transparent_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_Freebind_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_TcpFastOpenQueueLength_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_UdpListenerConfig_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_UdpListenerConfig_DownstreamSocketConfig_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_UdpListenerConfig_DownstreamSocketConfig_MaxRxDatagramSize_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_UdpListenerConfig_DownstreamSocketConfig_PreferGro_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_UdpListenerConfig_QuicOptions_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_UdpListenerConfig_QuicOptions_QuicProtocolOptions_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_UdpListenerConfig_QuicOptions_QuicProtocolOptions_MaxConcurrentStreams_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_UdpListenerConfig_QuicOptions_IdleTimeout_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_UdpListenerConfig_QuicOptions_CryptoHandshakeTimeout_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_UdpListenerConfig_QuicOptions_Enabled_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_UdpListenerConfig_QuicOptions_Enabled_DefaultValue_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_ApiListener_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_ApiListener_ApiListener_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_ConnectionBalanceConfig_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_TcpBacklogSize_state_atomicMessageInfo_initMu);
	run mutexMonitor(currentListenerEntry_listener_BindToPort_state_atomicMessageInfo_initMu);
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true -> 
					

					if
					:: true -> 
						goto stop_process
					fi
				fi
			:: true;
			fi
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			

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
			

			if
			:: true -> 
				

				if
				:: true -> 
					

					if
					:: true -> 
						goto stop_process
					fi
				fi
			:: true;
			fi
		:: true -> 
			goto stop_process
		fi
	fi;
	run mutexMonitor(l_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_Address_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_UseOriginalDst_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_DefaultFilterChain_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_DefaultFilterChain_FilterChainMatch_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_DefaultFilterChain_FilterChainMatch_DestinationPort_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_DefaultFilterChain_FilterChainMatch_SuffixLen_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_DefaultFilterChain_UseProxyProto_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_DefaultFilterChain_Metadata_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_DefaultFilterChain_TransportSocket_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_DefaultFilterChain_TransportSocketConnectTimeout_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_DefaultFilterChain_OnDemandConfiguration_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_DefaultFilterChain_OnDemandConfiguration_RebuildTimeout_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_DefaultFilterChain_HiddenEnvoyDeprecatedTlsContext_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_DefaultFilterChain_HiddenEnvoyDeprecatedTlsContext_CommonTlsContext_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_DefaultFilterChain_HiddenEnvoyDeprecatedTlsContext_CommonTlsContext_TlsParams_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_DefaultFilterChain_HiddenEnvoyDeprecatedTlsContext_CommonTlsContext_TlsCertificateCertificateProvider_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_DefaultFilterChain_HiddenEnvoyDeprecatedTlsContext_CommonTlsContext_TlsCertificateCertificateProviderInstance_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_DefaultFilterChain_HiddenEnvoyDeprecatedTlsContext_CommonTlsContext_CustomHandshaker_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_DefaultFilterChain_HiddenEnvoyDeprecatedTlsContext_CommonTlsContext_CustomHandshaker_TypedConfig_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_DefaultFilterChain_HiddenEnvoyDeprecatedTlsContext_RequireClientCertificate_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_DefaultFilterChain_HiddenEnvoyDeprecatedTlsContext_RequireSni_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_DefaultFilterChain_HiddenEnvoyDeprecatedTlsContext_SessionTimeout_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_PerConnectionBufferLimitBytes_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_Metadata_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_DeprecatedV1_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_DeprecatedV1_BindToPort_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_ListenerFiltersTimeout_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_Transparent_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_Freebind_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_TcpFastOpenQueueLength_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_UdpListenerConfig_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_UdpListenerConfig_DownstreamSocketConfig_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_UdpListenerConfig_DownstreamSocketConfig_MaxRxDatagramSize_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_UdpListenerConfig_DownstreamSocketConfig_PreferGro_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_UdpListenerConfig_QuicOptions_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_UdpListenerConfig_QuicOptions_QuicProtocolOptions_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_UdpListenerConfig_QuicOptions_QuicProtocolOptions_MaxConcurrentStreams_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_UdpListenerConfig_QuicOptions_IdleTimeout_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_UdpListenerConfig_QuicOptions_CryptoHandshakeTimeout_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_UdpListenerConfig_QuicOptions_Enabled_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_UdpListenerConfig_QuicOptions_Enabled_DefaultValue_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_ApiListener_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_ApiListener_ApiListener_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_ConnectionBalanceConfig_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_TcpBacklogSize_state_atomicMessageInfo_initMu);
	run mutexMonitor(l_BindToPort_state_atomicMessageInfo_initMu);
	run mutexMonitor(pluginParams_Node_Locality_state_atomicMessageInfo_initMu);
	run mutexMonitor(pluginParams_ServiceInstance_Service_Mutex);
	run mutexMonitor(pluginParams_ServiceInstance_Endpoint_EnvoyEndpoint_state_atomicMessageInfo_initMu);
	run mutexMonitor(pluginParams_ServiceInstance_Endpoint_EnvoyEndpoint_Metadata_state_atomicMessageInfo_initMu);
	run mutexMonitor(pluginParams_ServiceInstance_Endpoint_EnvoyEndpoint_LoadBalancingWeight_state_atomicMessageInfo_initMu);
	run mutexMonitor(pluginParams_Push_proxyStatusMutex);
	run mutexMonitor(pluginParams_Push_JwtKeyResolver_keyEntries_mu);
	run mutexMonitor(pluginParams_Push_networksMu);
	run mutexMonitor(pluginParams_Push_initializeMutex);
	

	if
	:: configgen_Plugins-1 != -3 -> 
				for(i : 0.. configgen_Plugins-1) {
			for30: skip;
			run OnOutboundListener2348(pluginParams_Node_Locality_state_atomicMessageInfo_initMu,pluginParams_ServiceInstance_Service_Mutex,pluginParams_ServiceInstance_Endpoint_EnvoyEndpoint_state_atomicMessageInfo_initMu,pluginParams_ServiceInstance_Endpoint_EnvoyEndpoint_Metadata_state_atomicMessageInfo_initMu,pluginParams_ServiceInstance_Endpoint_EnvoyEndpoint_LoadBalancingWeight_state_atomicMessageInfo_initMu,pluginParams_Push_proxyStatusMutex,pluginParams_Push_JwtKeyResolver_keyEntries_mu,pluginParams_Push_networksMu,pluginParams_Push_initializeMutex,child_OnOutboundListener23480);
			child_OnOutboundListener23480?0;
			for30_end: skip
		};
		for30_exit: skip
	:: else -> 
		do
		:: true -> 
			for31: skip;
			run OnOutboundListener2348(pluginParams_Node_Locality_state_atomicMessageInfo_initMu,pluginParams_ServiceInstance_Service_Mutex,pluginParams_ServiceInstance_Endpoint_EnvoyEndpoint_state_atomicMessageInfo_initMu,pluginParams_ServiceInstance_Endpoint_EnvoyEndpoint_Metadata_state_atomicMessageInfo_initMu,pluginParams_ServiceInstance_Endpoint_EnvoyEndpoint_LoadBalancingWeight_state_atomicMessageInfo_initMu,pluginParams_Push_proxyStatusMutex,pluginParams_Push_JwtKeyResolver_keyEntries_mu,pluginParams_Push_networksMu,pluginParams_Push_initializeMutex,child_OnOutboundListener23481);
			child_OnOutboundListener23481?0;
			for31_end: skip
		:: true -> 
			break
		od;
		for31_exit: skip
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
	

	if
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype OnOutboundListener2348(Mutexdef in_Node_Locality_state_atomicMessageInfo_initMu;Mutexdef in_ServiceInstance_Service_Mutex;Mutexdef in_ServiceInstance_Endpoint_EnvoyEndpoint_state_atomicMessageInfo_initMu;Mutexdef in_ServiceInstance_Endpoint_EnvoyEndpoint_Metadata_state_atomicMessageInfo_initMu;Mutexdef in_ServiceInstance_Endpoint_EnvoyEndpoint_LoadBalancingWeight_state_atomicMessageInfo_initMu;Mutexdef in_Push_proxyStatusMutex;Mutexdef in_Push_JwtKeyResolver_keyEntries_mu;Mutexdef in_Push_networksMu;Mutexdef in_Push_initializeMutex;chan child) {
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


