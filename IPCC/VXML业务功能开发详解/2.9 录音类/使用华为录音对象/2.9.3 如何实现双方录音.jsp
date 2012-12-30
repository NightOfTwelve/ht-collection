<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
		<var name="curSSP"/>
		<var name="callee_SSP"/>
		<var name="curConfNo"/>
	<form id="Begin_callout">
		<!-- ��ȡ��ǰ����SSP -->
		<object name="getcurssp" classid="method://huawei/Other/GetCurSSP">
			<param name="SSP" expr="curSSP"/>
		</object>
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


		<!--���-->
		<object name="callout" classid="method://huawei/Call/CallOut">
			<param name="CLI" expr="'112'"/>
			<param name="CLD" expr="'7105'"/>
			<param name="SSP" expr="callee_SSP"/>

			<filled>				
				<if cond="callout=='HOOK_OFF'">
					<log expr="'hook off and go on ' + callee_SSP" />
					<clear namelist="startconfrecord joinconf joinconf2"/>
				<else/>
					<log expr="'not hook off and return'"/>
					<goto next="#calleeRelease"/>					
				</if>
			</filled>
		</object>
		
		<var name="channel1"/>
		<var name="channel2"/>
		<var name="curDelChannel" expr="'0'"/>
		
		<!--�����᳡¼��-->
		<object name="startconfrecord" classid="method://huawei/Conf/ConfRecord" expr="true">
			<!-- �᳡�� -->
			<param name="ConfNO" expr="curConfNo"/>
			<!-- ¼����ʽ l 
				2��24K VOX
				4��64K Line PCM
				8��32K VOX
				16��Alaw PCM
				Ĭ��ֵΪ2�� -->
			<param name="RecordFormat" value ="2"/>
			<!-- ¼������ 
			 	1��IVR ָ���ļ���
				15��ҵ��ָ���ļ���
				Ĭ��ֵΪ1������ʹ��15��-->
			<param name="RecordType" value ="15"/>
			<!-- ¼��ģʽ 0��ʾ����,1��ʾ׷��,Ĭ��Ϊ0 -->
			<param name="RecordMode" value="0"/>
			<!-- ���¼��ʱ�� ��Ĭ��Ϊ30 �롣0 ��ʾ������¼����ֱ��ֹͣ¼���������·� -->
			<param name="MaxTime" value="0"/>
			<!-- ��"RecordType��=��1��ʱ����FileName��Ϊ�����������ʾƽ̨���ص�¼���ļ�����
				 ����RecordType��=��15��ʱ��FileName Ϊ�����������ʾ¼���ļ���ָ�����λ�á�
				 ��FileName��֧�ֵ���󳤶�Ϊ145 ���ֽ� -->
			<param name="FileName" expr="getFileName()"/>
			<param name="RecordBack" value="1"/>
		</object>
		
		<!--�����û�����᳡-->
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
		
		<!--�����û�����᳡-->
		<object name="joinconf2" classid=" method://huawei/Conf/ConfAddUser" expr="true">
			<!-- �᳡�� -->
			<param name="ConfNO" expr="curConfNo"/>
			<!-- ���ӷ�SSP -->
			<param name="SrcSSP" expr="callee_SSP"/>
			<!-- ���ӷ����� 0��ʾ���з�,Ŀǰֻ֧������0 -->
			<param name="ConnPartyType" value="0"/>
			<!-- �����û��ڻ᳡�е�ͨ���� -->
			<param name="ChannelNO" expr="channel2"/>
		</object>
		
		<object name="ProcessRBT" classid="method://huawei/Other/ProcessEvent" >
			<param name="OutputInfo" expr="outputinfo"/>
			<filled>
				<if cond="ProcessRBT=='USER_HOOK'">
					<if cond="outputinfo==curSSP">
						<goto next="#callerRelease"/>
					<else/>
						<assign name="curDelChannel" expr="channel2"/>
						<clear namelist="delUser releaseCallSSP"/>
					</if>
				<else/>
					<clear namelist="ProcessRBT"/>
				</if>
			</filled>
		</object>
		<!-- �û��˳��᳡ -->
		<object name="delUser" classid=" method://huawei/Conf/ConfDelUser" expr="true">
			<param name="ConfNO" expr="curConfNo"/>
			<param name="ChannelNO" expr="curDelChannel"/>
		</object>
		
		<object name="releaseCallSSP" classid="method://huawei/Call/Disconnect" expr="true">
			<!-- �һ��ͷ� -->
			<param name="Cause" value="4"/>
			<param name="SSP" expr="outputinfo"/>
			<filled>
				<clear namelist="ProcessRBT"/>
			</filled>
		</object>
	</form>
	
	<form id="callerRelease">
		<block>
			<log>ssp:<value expr="curSSP"/></log>
			<log>outssp:<value expr="callee_SSP"/></log>
		</block>
		<object name="releaseCaller" classid="method://huawei/Call/Disconnect" >
			<!-- �һ��ͷ� -->
			<param name="Cause" value="4"/>
			<param name="SSP" expr="curSSP"/>
		</object>
		
		<object name="releaseCallee" classid="method://huawei/Call/Disconnect" >
			<!-- �������� -->
			<param name="Cause" value="0"/>
			<param name="SSP" expr="callee_SSP"/>
		</object>
		<filled>
			<goto next="#delConf"/>
		</filled>
	</form>
	
	
	<form id="delConf">
		<block>
			<log>confNo:<value expr="curConfNo"/></log>
		</block>
		
		<!-- ֹͣ�᳡¼�� -->
		<object name="stopconfrecord" classid=" method://huawei/Conf/ConfStopRecord" >
			<param name="ConfNO" expr="curConfNo"/>
		</object>
				
		<!-- �ͷŻ᳡ -->
		<object name="releaseConf" classid="method://huawei/Conf/ReleaseConf">
			<param name="ConfNO" expr="curConfNo"/>
			<filled>
				<if cond="releaseConf=='SUCCESS'">
					<log>�ͷŻ᳡�ɹ�</log>
				</if>
			</filled>
		</object>
	</form>
</vxml>