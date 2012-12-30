<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
	<form >
		<var name="curSSP"/>
		<var name="curConfNo"/>
		
		<!-- ��ȡ��ǰ����SSP -->
		<object name="getcurssp" classid="method://huawei/Other/GetCurSSP">
			<param name="SSP" expr="curSSP"/>
		</object>

		<var name="curConfNo"/>
		
		<!--�����᳡-->
		<object name="createconf" classid="method://huawei/Conf/CreateConf">
			<!-- �᳡�� -->
			<param name="ConfNO" expr="curConfNo"/>
			<!-- �᳡ͨ���� -->
            <param name="ChannelNum" expr="'2'"/>
             <!-- ������־,0��ʾ������,Ĭ��Ϊ0 -->
            <param name="CVFlag" expr="'0'"/>
            <filled>
            	<if cond="createconf=='SUCCESS'">
            		<clear namelist="joinconf"/>
            	<else/>
            		<exit/>
            	</if>
            </filled>
		</object>
		
		<var name="channel1"/>
		<!--�û�����᳡-->
		<object name="joinconf" classid=" method://huawei/Conf/ConfAddUser" expr="true">
			<!-- �᳡�� -->
			<param name="ConfNO" expr="curConfNo"/>
			<!-- ���ӷ�SSP -->
			<param name="SrcSSP" expr="curSSP"/>
			<!-- ���ӷ����� 0��ʾ���з�,Ŀǰֻ֧������0 -->
			<param name="ConnPartyType" value="0"/>
			<!-- �����û��ڻ᳡�е�ͨ���� -->
			<param name="ChannelNO" expr="channel1"/>
		</object>

		<var name="outputinfo"/>
		<!-- �¼����� -->
		<object name="processEvent" classid="method://huawei/Other/ProcessEvent">
			<param name="OutputInfo" expr="outputinfo"/>
			<filled>
				<!-- �û��һ� -->
				<if cond="processEvent=='USER_HOOK'">
					<clear namelist="releaseCall releaseConf"/>
				<else/>
					<clear namelist="processEvent"/>
				</if>
			</filled>
		</object>
		
		<object name="releaseCall" classid="method://huawei/Call/Disconnect" expr="true">
			<!-- �һ��ͷ� -->
			<param name="Cause" value="4"/>
			<param name="SSP" expr="curSSP"/>
		</object>
		
		<!-- �ͷŻ᳡ -->
		<object name="releaseConf" classid="method://huawei/Conf/ReleaseConf" expr="true">
			<param name="ConfNO" expr="curConfNo"/>
			<filled>
				<if cond="releaseConf=='SUCCESS'">
					<log>�ͷŻ᳡�ɹ�</log>
				</if>
			</filled>
		</object>
	</form>
	
</vxml>