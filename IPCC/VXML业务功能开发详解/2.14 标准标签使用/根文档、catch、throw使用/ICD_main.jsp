<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0" application="ICD_root.jsp">

	<form id="playdrvbagein">
		<script>
			var timeoutCount = 0;
			function countAdd(){
				timeoutCount=timeoutCount+1;
				return timeoutCount;
			}
		</script>
		<property name="interdigittimeout" value="10"/>
		<property name="inputmodes" value="dtmf"/>
		<property name="bargein" value="true"/>
		<field name="collect" type="digits">
			<property name="maxdigit" value="3"/>
			<prompt timeout="10"> 
				<audio expr="getFullAudio('DefaultPlay.wav');"/>						
			</prompt>
			<filled>
			<!-- ���ź�λ���պų�ʱ -->
				<log>���������:<value expr="collect"/></log>
				<throw event="diconnectCalling"/>
			</filled>
			<!-- ������ASR�պ� -->
			<catch event="nomatch">
				<log>û��ƥ��</log>
				<throw event="exit"/>
			</catch>
			<!-- ��λ�պų�ʱ -->
			<catch event="noinput">
				<log>û������</log>
				<if cond="countAdd()==failCount">
					<throw event="diconnectCalling"/>
				<else/>
					<clear namelist="collect"/>
				</if>
			</catch>
			<catch event="timeout">
				<log>ע�ⳬʱ</log>
				<throw event="exit"/>
			</catch>
		</field>
	</form>	
</vxml>