<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
	<form id="playdrvbagein">
		<property name="inputmodes" value="dtmf"/>
		<property name="bargein" value="true"/>			
		
		<field name="collect" type="digits">
		<property name="maxdigit" value="1"/>
		<prompt >
			<audio src="d:\wait.wav"/>						
		</prompt>
		<filled>
			���������
			<value expr="collect"/>
			<log>���������:<value expr="collect"/></log>
		</filled>
		<catch event="nomatch">
			û��ƥ��
			<throw event="exit"/>
		</catch>
		<catch event="noinput">
			û������
			<throw event="exit"/>
		</catch>
		<catch event="timeout">
			ע�ⳬʱ
			<throw event="exit"/>
		</catch>
		
		</field>
	</form>	
</vxml>