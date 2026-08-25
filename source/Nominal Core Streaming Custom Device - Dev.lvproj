<?xml version='1.0' encoding='UTF-8'?>
<Project Type="Project" LVVersion="26008000">
	<Property Name="SMProvider.SMVersion" Type="Int">201310</Property>
	<Item Name="My Computer" Type="My Computer">
		<Property Name="IOScan.Faults" Type="Str"></Property>
		<Property Name="IOScan.NetVarPeriod" Type="UInt">100</Property>
		<Property Name="IOScan.NetWatchdogEnabled" Type="Bool">false</Property>
		<Property Name="IOScan.Period" Type="UInt">10000</Property>
		<Property Name="IOScan.PowerupMode" Type="UInt">0</Property>
		<Property Name="IOScan.Priority" Type="UInt">9</Property>
		<Property Name="IOScan.ReportModeConflict" Type="Bool">true</Property>
		<Property Name="IOScan.StartEngineOnDeploy" Type="Bool">false</Property>
		<Property Name="server.app.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.control.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.tcp.enabled" Type="Bool">false</Property>
		<Property Name="server.tcp.port" Type="Int">0</Property>
		<Property Name="server.tcp.serviceName" Type="Str">My Computer/VI Server</Property>
		<Property Name="server.tcp.serviceName.default" Type="Str">My Computer/VI Server</Property>
		<Property Name="server.vi.callsEnabled" Type="Bool">true</Property>
		<Property Name="server.vi.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="specify.custom.address" Type="Bool">false</Property>
		<Item Name="binaries" Type="Folder">
			<Item Name="lib_nominal-streaming-lv_32.dll" Type="Document" URL="../lib_nominal-streaming-lv_32.dll"/>
			<Item Name="lib_nominal-streaming-lv_64.dll" Type="Document" URL="../lib_nominal-streaming-lv_64.dll"/>
			<Item Name="lib_nominal-streaming-lv_64.dylib" Type="Document" URL="../lib_nominal-streaming-lv_64.dylib"/>
			<Item Name="lib_nominal-streaming-lv_64.so" Type="Document" URL="../lib_nominal-streaming-lv_64.so"/>
			<Item Name="nominalClient_32.dll" Type="Document" URL="../nominalClient_32.dll"/>
			<Item Name="nominalClient_64.dll" Type="Document" URL="../nominalClient_64.dll"/>
			<Item Name="nominalClient_64.so" Type="Document" URL="../nominalClient_64.so"/>
		</Item>
		<Item Name="NI VeriStand APIs" Type="Folder">
			<Item Name="Custom Device API.lvlib" Type="Library" URL="/&lt;vilib&gt;/NI VeriStand/Custom Device API/Custom Device API.lvlib"/>
			<Item Name="Custom Device Utility Library.lvlib" Type="Library" URL="/&lt;vilib&gt;/NI VeriStand/Custom Device Tools/Custom Device Utility Library/Custom Device Utility Library.lvlib"/>
		</Item>
		<Item Name="Utility" Type="Folder">
			<Item Name="Copy .LLB to NI VeriStand dir.vi" Type="VI" URL="../Utility/Copy .LLB to NI VeriStand dir.vi"/>
		</Item>
		<Item Name="Custom Device Nominal Core Streaming.xml" Type="Document" URL="../Custom Device Nominal Core Streaming.xml"/>
		<Item Name="Nominal Core Streaming Engine.lvlib" Type="Library" URL="../Engine/Nominal Core Streaming Engine.lvlib"/>
		<Item Name="Nominal Core Streaming Shared.lvlib" Type="Library" URL="../Shared/Nominal Core Streaming Shared.lvlib"/>
		<Item Name="Nominal Core Streaming System Explorer.lvlib" Type="Library" URL="../System Explorer/Nominal Core Streaming System Explorer.lvlib"/>
		<Item Name="Dependencies" Type="Dependencies"/>
		<Item Name="Build Specifications" Type="Build"/>
	</Item>
</Project>
