<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
	<form id="playdrvbagein">
		<script>
			var timeoutCount = 0;
			function countAdd(){
				timeoutCount=timeoutCount+1;
				return timeoutCount;
			}
		</script>
		<%
			String timeout = (String)request.getParameter("timeout");
		%>
		<var name="testInfo"/>
		<var name="timeout" expr="'<%=timeout%>'"/>
		<block>
			<log>2:testInfo:<value expr="testInfo"/></log>
			<log>2:timeout:<value expr="timeout"/></log>
		</block>
		<property name="interdigittimeout" value="10"/>
		<property name="inputmodes" value="dtmf"/>
		<property name="bargein" value="true"/>
		<property name="timeout" value="5"/>				
		<field name="collect" type="digits">
			<property name="maxdigit" value="3"/>
			<prompt  timeout="10"> <!-- ���ȼ�������Ĵ� -->
				<audio src="y:\DefaultPlay.wav"/>						
			</prompt>
			<filled>
			<!-- ���ź�λ���պų�ʱ -->
				<log>���������:<value expr="collect"/></log>
				<return namelist="collect testInfo timeoutCount"/>
			</filled>
			<!-- ������ASR�պ� -->
			<catch event="nomatch">
				<log>û��ƥ��</log>
				<throw event="exit"/>
			</catch>
			<!-- ��λ�պų�ʱ -->
			<catch event="noinput">
				<log>û������</log>
				<if cond="countAdd()==2">
					<exit/>
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