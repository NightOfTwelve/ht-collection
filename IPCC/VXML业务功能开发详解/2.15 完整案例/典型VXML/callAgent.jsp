<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0" application="root.jsp">
	<property name="inputmodes" value="dtmf"/>
	<var name="tranAgentTimes" expr="0"/>
	<var name="agentDuration" expr="0"/>
	<var name="retResult" expr="'FAILURE'"/>
	<var name="isQueuing"/>
	<catch event="connection.disconnect.hangup">
		<if cond="isQueuing=='1'">
			<assign name="retResult" expr="'isQueuing'"/>
			<else/>
			<assign name="retResult" expr="'logAuto'"/>
		</if>
		<return namelist="retResult endReason queueTimes"/>
	</catch>
	<form id="callAgent">
		<var name="agentPhoneNumber"/>
		<var name="agentWav"/>
		<block>
			<log label="toAgent">
				callAgent:
				<value expr="agentWav"/>
				,
				<value expr="agentPhoneNumber"/>
			</log>
			<assign name="queueStartTime" expr="getCurrentTime()"/>
			<!-- �Ŷ��йһ� -->
			<assign name="endReason" expr="'3'"/>
			<goto nextitem="preAgent"/>
		</block>
		<block name="preAgent">
			<!-- �Ŷ��йһ� -->
			<assign name="endReason" expr="'3'"/>
			<assign name="queueTimes" expr="queueTimes+1"/>
			<assign name="isQueuing" expr="'0'"/>
			<goto nextitem="agent"/>
		</block>
		
		<object name="agent" classid="method://huawei/Other/RequestRouting" >
		
			<!-- ·������ 1���պ���Ϣ��2���û���������3����ϯ���š�4���˹�̨���� -->
			<param name="RoutingType" value="2"/>
			
			<!-- ·����Ϣ 1�����̽�����򱻽к��롢2�����ܶ������ƣ�������̨�鿴����3����ϯ�Ĺ��š�4��·����ϢΪ�գ�����������̨������������������ -->
			<param name="RoutingInfo" value="voice1"/>
			
			<!-- WaitReturn�Ƿ�ȴ����أ�0��ʾ���ȴ����أ�1��ʾ�ȴ����أ�10��ʾ·��ת��IVR -->
			<param name="WaitReturn" value="1"/>
			
			<!-- QueueFlag�Ƿ��Ŷӱ�ǣ�0��ʾ���Ŷӣ�1��ʾ�Ŷ� -->
			<param name="QueueFlag" value="1"/>
			
			<filled>
				<assign name="isQueuing" expr="'0'"/>
				<assign name="tranAgentTimes" expr="tranAgentTimes+1"/>
				<log label="toAgent">
					<value expr="agent"/>
				</log>
				<!-- ·�ɳɹ� -->
				<if cond="agent=='OPR_SUCCESS'">
					<clear namelist="agent"/>
				<!-- �û��һ� -->
				<elseif cond="agent=='USER_HOOK'"/>
					<assign name="endReason" expr="'9'"/>
					<throw event="logAuto"/>
					<goto next="#returnResult"/>				
				<elseif cond="agent=='OPR_NOTIFY'"/>
					<log>�˹�̨ת��</log>
					<assign name="endReason" expr="'9'"/>
					<assign name="retResult" expr="'SUCCESS'"/>
					<goto next="#returnResult"/>
				<else/>
					<goto nextitem="callAgentFail"/>
				</if>
			</filled>
		</object>
		<block name="callAgentFail">
			<assign name="endReason" expr="'5'"/>
			<assign name="isQueuing" expr="'1'"/>
			<if cond="tranAgentTimes==3">
				<assign name="endReason" expr="'c'"/>
				<prompt>
					<audio expr="getFullAudio('24.wav')">
						ϵͳæ��ллʹ�ã��ټ�
					</audio>
				</prompt>
				<throw event="diconnectCalling"/>
				<else/>
				<assign name="endReason" expr="'b'"/>
				<goto nextitem="callAgentAg"/>
			</if>
		</block>
		<field name="callAgentAg" type="digits?minlength=1;maxlength=1">
			<property name="inputmodes" value="dtmf"/>
			<property name="timeout" value="10"/>
			<property name="termchar" value="#"/>
			<prompt>
				<audio expr="getFullAudio('21.wav')">
					����æ�������ȴ��밴1��������һ�
				</audio>
			</prompt>
			<filled>
				<if cond="callAgentAg==1">
					<clear namelist="callAgentAg agent"/>
					<goto nextitem="preAgent"/>
					<else/>
					<clear namelist="callAgentAg agent"/>
					<prompt>
						<audio expr="getFullAudio('22.wav')">
							���������������
						</audio>
					</prompt>
					<goto nextitem="callAgentAg"/>
				</if>
			</filled>
			<catch event="nomatch">
				<throw event="noinput"/>
			</catch>
			<catch event="noinput" count="1,2">
				<prompt>
					<audio expr="getFullAudio('22.wav')">
						���������������
					</audio>
				</prompt>
				<reprompt/>
			</catch>
			<catch event="noinput" count="3">
				<assign name="endReason" expr="'c'"/>
				<prompt>
					<audio expr="getFullAudio('23.wav')">
						ллʹ�ã��ټ���
					</audio>
				</prompt>
				<!--<throw event="diconnectCalling"/>-->
				<assign name="retResult" expr="'secQueuet'"/>
				<return namelist="retResult endReason queueTimes"/>
			</catch>
		</field>
	</form>
	<form id="returnResult">
		<block>
			<return namelist="retResult endReason queueTimes"/>
		</block>
	</form>
</vxml>
